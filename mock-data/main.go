package main

import (
	"encoding/csv"
	"fmt"
	"log"
	"os"
	"time"

	"github.com/joho/godotenv"
)

func main() {

	err := godotenv.Load("../.env")
	if err != nil {
		log.Fatal("error-load-env:", err.Error())
	}

	amount := 100
	var generator Generator
	items := generator.generateItems(amount)

	filename := fmt.Sprintf("test_csv_%v", time.Now().Format("2006-01-02 15:04:05"))
	filePath := fmt.Sprintf("%s.csv", filename)
	osFile, _ := os.Create(filePath)
	defer osFile.Close()

	writer := csv.NewWriter(osFile)
	defer writer.Flush()

	headers := []string{"id", "name", "serial", "createdAt"}

	if err := writer.Write(headers); err != nil {
		log.Fatal("error", err.Error())
		return
	}

	for _, item := range items {
		row := []string{item.ID, item.Name, item.Serial, item.CreatedAt.Format("2006-01-02 15:04:05")}
		if err := writer.Write(row); err != nil {
			log.Fatal("error", err.Error())
			return
		}
	}

	fmt.Printf("Successfully generated CSV file with %d items!\n", amount)

	s3 := GetS3Client()
	if err := s3.UploadFile(fmt.Sprintf("%v.csv", filename), filePath); err != nil {
		log.Println("error upload::", err.Error())
	}

}
