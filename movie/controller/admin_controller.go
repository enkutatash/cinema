package controller

import (
	"movie/models"
	"movie/usercase"

	"github.com/gin-gonic/gin"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

var (
	adminUsecase usercase.AdminUseCase
)

type AdminController interface {
	AddMovie(c *gin.Context)
	UpdateMovie(c *gin.Context)
	DeleteMovie(c *gin.Context)
	AddHall(c *gin.Context)
	RemoveHall(c *gin.Context)
	UpdateHall(c *gin.Context)

	AddShowtime(c *gin.Context)
	DeleteShowTime(c *gin.Context)
	RescheduleMovie(c *gin.Context)
	ChangeUserRole(c *gin.Context)
}

type admincontroller struct{}

// DeleteShowTime implements AdminController.
func (a *admincontroller) DeleteShowTime(c *gin.Context) {
	c.Header("Content-Type", "application/json")
	ID := c.Param("showtimeid")
	if ID == "" {
		c.JSON(400, gin.H{
			"error": "showtime id is required",
		})
		return
	}

	err := adminUsecase.DeleteShowTime(ID)
	if err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, gin.H{"message": "Showtime deleted successfully"})
}

// AddHall implements AdminController.
func (a *admincontroller) AddHall(c *gin.Context) {
	c.Header("Content-Type", "application/json")
	var hall models.Hall
	if err := c.ShouldBind(&hall); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	hall.HallID = primitive.NewObjectID()
	if err := validate.Struct(hall); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}

	err := adminUsecase.AddHall(&hall)
	if err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, gin.H{"message": "Hall added successfully"})

}

// AddMovie implements AdminController.
func (a *admincontroller) AddMovie(c *gin.Context) {
	c.Header("Content-Type", "application/json")
	var movie models.Movie
	if err := c.ShouldBind(&movie); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	movie.MovieID = primitive.NewObjectID()
	if err := validate.Struct(movie); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}

	err := adminUsecase.AddMovie(&movie)
	if err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, gin.H{"message": "movie added successfully"})
}

// AddShowtime implements AdminController.
func (a *admincontroller) AddShowtime(c *gin.Context) {
	c.Header("Content-Type", "application/json")
	var showTime models.ShowTime
	if err := c.ShouldBind(&showTime); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	if err := validate.Struct(showTime); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	showTime.ShowTimeID = primitive.NewObjectID()
	showTime.TakenSeats = make(map[string]string)
	showTime.AvailableSeats = []string{}
	err := adminUsecase.AddShowtime(&showTime)
	if err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, gin.H{"message": "Showtime added successfully"})
}



// ChangeUserRole implements AdminController.
func (a *admincontroller) ChangeUserRole(c *gin.Context) {
	c.Header("Content-Type", "application/json")
	type Temp struct {
		Email string `json:"email" validate:"required,email"`
		Role  string `json:"role" validate:"required"`
	}
	var temp Temp
	if err := c.ShouldBind(&temp); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}

	if err := validate.Struct(temp); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	err := adminUsecase.ChangeUserRole(temp.Email, temp.Role)
	if err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, gin.H{"message": "User role changed successfully"})
}

// DeleteMovie implements AdminController.
func (a *admincontroller) DeleteMovie(c *gin.Context) {
	c.Header("Content-Type", "application/json")
	ID := c.Param("movieid")
	if ID == "" {
		c.JSON(400, gin.H{
			"error": "movie id is required",
		})
		return
	}

	err := adminUsecase.DeleteMovie(ID)
	if err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, gin.H{"message": "Movie deleted successfully"})
}

// RemoveHall implements AdminController.
func (a *admincontroller) RemoveHall(c *gin.Context) {
	c.Header("Content-Type", "application/json")
	ID := c.Param("hallid")
	if ID == "" {
		c.JSON(400, gin.H{
			"error": "hall id is required",
		})
	}
	err := adminUsecase.RemoveHall(ID)
	if err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, gin.H{"message": "Hall deleted successfully"})
}

// RescheduleMovie implements AdminController.
func (a *admincontroller) RescheduleMovie(c *gin.Context) {
	c.Header("Content-Type", "application/json")
	ID := c.Param("showtimeid")
	if ID == "" {
		c.JSON(400, gin.H{
			"error": "showtime id is required",
		})
		return
	}
	var showTime models.ShowTime
	if err := c.ShouldBind(&showTime); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	err := adminUsecase.RescheduleMovie(&showTime, ID)
	if err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, gin.H{"message": "Showtime rescheduled successfully"})
}

// UpdateHall implements AdminController.
func (a *admincontroller) UpdateHall(c *gin.Context) {
	c.Header("Content-Type", "application/json")
    ID := c.Param("hallid")
	if ID == "" {
		c.JSON(400, gin.H{
			"error": "hall id is required",
		})
		return
	}
	var hall models.Hall
	if err := c.ShouldBind(&hall); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	err := adminUsecase.UpdateHall(&hall,ID)
	if err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, gin.H{"message": "Hall updated successfully"})
}

// UpdateMovie implements AdminController.
func (a *admincontroller) UpdateMovie(c *gin.Context) {
	c.Header("Content-Type", "application/json")
	ID := c.Param("movieid")
	if ID == "" {
		c.JSON(400, gin.H{
			"error": "movie id is required",
		})
		return
	}
	var movie models.Movie
	if err := c.ShouldBind(&movie); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	err := adminUsecase.UpdateMovie(&movie,ID)
	if err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, gin.H{"message": "Movie updated successfully"})
}

func NewAdminController(adminusecase usercase.AdminUseCase) AdminController {
	adminUsecase = adminusecase
	return &admincontroller{}
}
