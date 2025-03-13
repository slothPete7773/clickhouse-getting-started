package main

import (
	"fmt"
	"math/rand"
	"time"
)

type Generator struct{}

type Item struct {
	ID        string
	Name      string
	Serial    string
	CreatedAt time.Time
}

// generateRandomString creates a random string of specified length
func generateRandomString(length int) string {
	const charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	result := make([]byte, length)
	for i := range result {
		result[i] = charset[rand.Intn(len(charset))]
	}
	return string(result)
}

// generateRandomDate creates a random date within the last year
func generateRandomDate() time.Time {
	// Generate a random time within the last year
	maxDuration := 365 * 24 * time.Hour
	randomDuration := time.Duration(rand.Int63n(int64(maxDuration)))
	randomTime := time.Now().Add(-randomDuration)

	// Format in the required format: DD/MM/YYYY HH:MM:SS
	// return randomTime.Format("02/01/2006 15:04:05")
	return randomTime
}

// getModelName returns a random model name
func getModelName() string {
	models := []string{
		"Brook Model 1/4",
		"Cascade XL-200",
		"Horizon Plus Z3",
		"Skyline Pro 500",
		"Thunder Basic 2.0",
		"Vertex Standard 10",
		"Wavelength Mini",
		"Zenith Elite V",
		"Alpine Series 4",
		"Quantum Light S",
	}

	return models[rand.Intn(len(models))]
}

func (Generator) generateItems(n int) []Item {
	items := make([]Item, n)

	for i := 0; i < n; i++ {
		items[i].ID = generateRandomString(8)
		items[i].Serial = fmt.Sprintf("%s_%s", generateRandomString(4), generateRandomString(6))
		items[i].Name = getModelName()
		items[i].CreatedAt = generateRandomDate()
	}

	return items
}
