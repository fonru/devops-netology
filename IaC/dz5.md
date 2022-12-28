# Задача 1

> Установите golang

```shell
[admin@localhost ~]$ sudo tar -C /usr/local -xzf go1.19.4.linux-amd64.tar.gz
[admin@localhost ~]$ export PATH=$PATH:/usr/local/go/bin
[admin@localhost ~]$ go version
go version go1.19.4 linux/amd64
```

# Задача 3

> Напишите программу для перевода метров в футы (1 фут = 0.3048 метр).

```go
package main

import "fmt"

func main() {
 fmt.Print("Enter a number: ")
 var value float64
 fmt.Scanf("%f", &value)
 futi := fut(value)
 fmt.Println("Value in futs: ", futi)
}

func fut(x float64) (result_fut float64) {
 result_fut = x * 0.3048
 return (result_fut)
}
```

> Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:

```go
package main

import "fmt"

var massive = []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9}

func main() {
 min_value := find_min_value(massive)
 fmt.Println("Minimum list value: ", min_value)
}

func find_min_value(massive []int) (min_value int) {
 min_value = massive[0]
 for _, value := range massive {
  if value < min_value {
   min_value = value

  }
 }
 return min_value
}
```

> Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3.

```go
package main

import "fmt"

func main() {
 fmt.Print(del3())
}

func del3() []int {
 massive := []int{}
 for i := 1; i <= 100; i++ {
  if i%3 == 0 {
   // fmt.Println(i)
   massive = append(massive, i)
  }

 }
 return massive
}

```

# Задача 4

Протестировать код (не обязательно).

1) Тест для первой программы (перевод в футы)

```go
package main

import "fmt"

func main() {
 fmt.Print("Enter a number: ")
 var value float64
 fmt.Scanf("%f", &value)
 futi := fut(value)
 fmt.Println("Value in futs: ", futi)
}

func fut(x float64) (result_fut float64) {
 result_fut = x * 0.3048
 return (result_fut)
}
```

2) Тест для второй программы (поиск наименьшего числа массива)

```go
package main

import "testing"

func TestFindMin(t *testing.T) {
 // Arranger
 a := []int{48, 96, 86, 68, 57, 82, 63, 70, 1}
 expected := 1
 // Act
 result := find_min_value(a)

 //Assert

 if result != expected {
  t.Errorf("Error. Expect %d, got %d", expected, result)
  // t.Error(expected, result)
 }
}
```

3) Тест для третьей программы (вывод всех чисел, делющиеся на 3)

```go
package main

import "testing"

func TestDel3(t *testing.T) {
 // Arranger
 expected := []int{3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57, 60, 63, 66, 69, 72, 75, 78, 81, 84, 87, 90, 93, 96, 99}

 // Act
 result := del3()

 //Assert

 if len(expected) != len(result) {
  t.Errorf("Arrays are diffrent")
 }
 for i, v := range expected {
  if v != result[i] {
   t.Error("Arrays are diffrent")
  }
 }
}
```
