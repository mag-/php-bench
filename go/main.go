package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strings"
)

func match(desk string, word string) bool {
	if desk == "" {
		return false
	}
	if word == "" {
		return true
	}
	w := word[0]
	ws := word[1:len(word)]
	if strings.ContainsRune(desk, rune(w)) {
		return match(strings.Replace(desk, string(w), "", 1), ws)
	}
	return false
}

func main() {
	f, err := os.Open("ODS6.txt")
	if err != nil {
		log.Fatal("Cannot open file")
	}
	scanner := bufio.NewScanner(f)
	for scanner.Scan() {
		line := scanner.Text()
		if match(os.Args[1], line) {
			fmt.Println(line)
		}
	}
	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "error reading standard:", err)
	}
}
