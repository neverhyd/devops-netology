# Домашнее задание к занятию "7.5. Основы golang"

## Задача 3. Написание кода. 
1.
    ```
    package main
    
    import "fmt"
    
    func main() {
        fmt.Print("Enter a number: ")
        var input float64
        fmt.Scanf("%f", &input)
    
        output := input * 0.3048
    
        fmt.Println(output)    
    }
    ```
 
1. 
    ```
    package main

	import "fmt"

	func main() {
		var x = []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17}
		var minx = 999
		for _, value := range x{
		 if value < minx { minx = value }
		}
		fmt.Println(" minx = ", minx)
	}

    ```
1. 
```
package main

import "fmt"

func main() {
    for x := 1; x<=100; x++ {
     if (x % 3) == 0 { fmt.Println(x) }
    }
}
```


