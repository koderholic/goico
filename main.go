package main

import (
	"net/http"

	spafs "github.com/koron/go-spafs"
)

func main() {
	fs := spafs.FileServer(http.Dir("./frontend/dist"))
	err := http.ListenAndServe(":8080", fs)
	if err != nil {
		panic(err)
	}
}
