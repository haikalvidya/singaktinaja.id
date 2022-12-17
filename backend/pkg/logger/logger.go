package logger

import (
	"fmt"
	"log"
	"mime/multipart"
	"net/http"
	"reflect"
	"regexp"
	"strings"

	mask "github.com/anu1097/golang-masking-tool"
	"github.com/anu1097/golang-masking-tool/customMasker"
	"github.com/anu1097/golang-masking-tool/filter"
)

func validateKey(key string) bool {
	lowerString := strings.ToLower(key)
	return strings.Contains(lowerString, "token") ||
		strings.Contains(lowerString, "secret") ||
		strings.Contains(lowerString, "password") ||
		strings.Contains(lowerString, "phone") ||
		strings.Contains(lowerString, "account_number")
}

func maskString(str string) string {
	maskTool := mask.NewMaskTool(filter.CustomValueFilter(str, customMasker.MPassword))
	if maskedStr, ok := maskTool.MaskDetails(str).(string); ok {
		return maskedStr
	}
	return str
}

func headerToLog(header http.Header) (str string) {

	rgx := regexp.MustCompile(`[-_]`)
	for key, v := range header {
		if validateKey(key) {
			for i, vChar := range v {
				v[i] = maskString(vChar)
			}
		}
		str = fmt.Sprintf(`%s %s="%s"`, str, strings.ToLower(rgx.ReplaceAllString(key, "_")), v)
	}

	return
}

func bodyToLog(data JsonBody) JsonBody {

	defer func() {
		if r := recover(); r != nil {
			log.Println("recover from bodyToLog", r)
		}
	}()

	for key, v := range data {
		switch reflect.ValueOf(v).Kind() {
		case reflect.Slice:
			for i, sl := range v.([]interface{}) {
				switch reflect.ValueOf(sl).Kind() {
				case reflect.Map:
					v.([]interface{})[i] = bodyToLog(sl.(JsonBody))
				case reflect.String:
					if validateKey(key) {
						sl = maskString(sl.(string))
					}
					v.([]interface{})[i] = sl
				}
			}
		case reflect.Map:
			data[key] = bodyToLog(v.(JsonBody))
		case reflect.String:
			if validateKey(key) {
				v = maskString(v.(string))
			}
			data[key] = v
		}
	}

	return data
}

func formDataToLog(formData *multipart.Form) JsonBody {

	data := make(JsonBody)

	for key, v := range formData.Value {
		if validateKey(key) {
			for i, vChar := range v {
				v[i] = maskString(vChar)
			}
		}
	}

	data["value"] = formData.Value
	data["file"] = formData.File

	return data
}
