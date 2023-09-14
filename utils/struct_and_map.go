package utils

import (
	"encoding/json"
	"fmt"
)

/* struct veriyi map[string]interface{}'e dönüştürür */
func StructToMap(obj interface{}) (newMap map[string]interface{}, err error) {
	data, err := json.Marshal(obj)
	if err != nil {
		return map[string]interface{}{}, err
	}

	err = json.Unmarshal(data, &newMap)
	return newMap, err
}

/* pointer kullanarak gelen map'i ve objeyi anlamlandırıyor */
func MapToStruct(mapData map[string]interface{}, structData interface{}) {
	jsonStr, err := json.Marshal(mapData)
	if err != nil {
		fmt.Println(err)
	}
	if err := json.Unmarshal(jsonStr, structData); err != nil {
		fmt.Println(err)
	}
}
