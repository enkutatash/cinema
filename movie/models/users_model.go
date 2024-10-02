package models

import (
	

	"go.mongodb.org/mongo-driver/bson/primitive"
)

type User struct {
	UserID   primitive.ObjectID `json:"userID"`
	FullName string             `json:"fullName" validate:"required"`
	Email    string             `json:"email"  validate:"required,email"`
	Password string             `json:"password"  validate:"required,min=6"`
	Role     string             `json:"role"`
	Token    string             `json:"token"`
}

type Movie struct {
	MovieID     primitive.ObjectID `json:"movieid"`
	Title       *string            `json:"title"`
	Year        *string            `json:"year"`
	Genre       *string            `json:"genre"`
	Duration    *string             `json:"duration"`
	Poster      *string            `json:"poster"`
	Trailer     *string            `json:"trailer"`
	Description *string            `json:"description"`
	Cast        []Person           `json:"cast"`
	Crew        Crew               `json:"crew"`
}

type Person struct {
	Name string `json:"name"`
	Role string `json:"role"`
}

type Crew struct {
	Director  []Person `json:"director"`
	Producer  []Person `json:"producer"`
	Writer    []Person `json:"writer"`
	CameraMan []Person `json:"cameraMan"`
}
