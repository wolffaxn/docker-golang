package main

import (
	"errors"
	"fmt"
	"strings"
)

func echo(args []string) error {
	if len(args) < 1 {
		return errors.New("Too few arguments")
	}
	_, err := fmt.Println(strings.Join(args[:], " "))
	return err
}

func main() {
	echo([]string{"hello,", "world"})
}
