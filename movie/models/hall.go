package models

import (
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

type Hall struct {
	HallID   primitive.ObjectID `json:"hallid"`
	Name     *string            `json:"name" validate:"required"`
	Rows     *[]int               `json:"rows" validate:"required"`
	Seats    *int               `json:"seats" validate:"required"`
	Location *string            `json:"location" validate:"required"`
}

type ShowTime struct {
	ShowTimeID primitive.ObjectID `json:"showtimeid"`
	MovieID    string             `json:"movieid" validate:"required"`
	HallID     string             `json:"hallid" validate:"required"`
	TimeStart  time.Time          `json:"timeStart" validate:"required"`
	TimeEnd    time.Time          `json:"timeEnd"`
	Price      float64            `json:"price"`
	TakenSeats map[string]string  `json:"takenSeats"`
	AvailableSeats []string 	 `json:"availableSeats"`
}
