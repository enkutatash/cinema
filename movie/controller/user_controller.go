package controller

import (
	"movie/models"
	"movie/token"
	"movie/usercase"

	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

var (
	validate    = validator.New()
	userUseCase usercase.UserUsecase
)

type UserController interface {
	Register(c *gin.Context)
	Login(c *gin.Context)
	GetAllMovie(c *gin.Context)
	GetMovieByFilter(c *gin.Context)
	GetMovieShowTime(c *gin.Context)
	GetAllSHowTime(c *gin.Context)
	ReserveForMovie(c *gin.Context)
	CancelReservation(c *gin.Context)
	ChangeSeat(c *gin.Context)
}

type usercontroller struct{}

// CancelReservation implements UserController.
func (u *usercontroller) CancelReservation(c *gin.Context) {

	showtime := c.Param("showtimeid")
	user , err := c.Get("client")
	if !err{
		c.JSON(400,gin.H{"error":"user not found"})
		return
	}
	type Seat struct{
		SeatPlace  string `json:"seat" validate:"required"`
	}
	var seat Seat
	if err := c.ShouldBind(&seat); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}

	if err := validate.Struct(seat); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	
	if showtime == "" {
		c.JSON(400, gin.H{
			"error": "showtime id is required",
		})
		return
	}
	er := userUseCase.CancelReservation(showtime, user.(*token.UserReg).ID,seat.SeatPlace)
	if er != nil {
		c.JSON(400, gin.H{
			"error": er.Error(),
		})
		return
	}
	c.JSON(200, gin.H{"message": "success"})

}

// ChangeSeat implements UserController.
func (u *usercontroller) ChangeSeat(c *gin.Context) {
	c.Header("Content-Type", "application/json")
	showtime := c.Param("showtimeid")
	user , err := c.Get("client")
	if !err{
		c.JSON(400,gin.H{"error":"user not found"})
		return
	}
	type Seat struct{
		NewSeat  string `json:"newseat" validate:"required"`
		OldSeat string `json:"oldseat" validate:"required"` 
	}
	var seat Seat
	if err := c.ShouldBind(&seat); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}

	if err := validate.Struct(seat); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	
	if showtime == "" {
		c.JSON(400, gin.H{
			"error": "showtime id is required",
		})
		return
	}
	er := userUseCase.ChangeSeat(showtime, user.(*token.UserReg).ID,seat.NewSeat,seat.OldSeat)
	if er != nil {
		c.JSON(400, gin.H{
			"error": er.Error(),
		})
		return
	}
	c.JSON(200, gin.H{"message": "success"})
}

// GetAllMovie implements UserController.
func (u *usercontroller) GetAllMovie(c *gin.Context) {
	movies , err := userUseCase.GetAllMovie()
	if err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200,movies)
}

// GetAllSHowTime implements UserController.
func (u *usercontroller) GetAllSHowTime(c *gin.Context) {

	showtimes , err := userUseCase.GetAllShowTime()
	if err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200,showtimes)
}

// GetMovieByFilter implements UserController.
func (u *usercontroller) GetMovieByFilter(c *gin.Context) {
	c.Header("Content-Type", "application/json")
	var filter struct{
		Title string `json:"title"`
		Genre string `json:"genre"`
		Year string `json:"year"`
	}
	if err := c.ShouldBind(&filter); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	movies , err := userUseCase.GetMovieByFilter(filter.Title,filter.Genre,filter.Year)
	if err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
		
	}	
	c.JSON(200,movies)
}

// GetMovieShowTime implements UserController.
func (u *usercontroller) GetMovieShowTime(c *gin.Context) {
	c.Header("Content-Type", "application/json")
	movieid := c.Param("movieid")
	if movieid == "" {
		c.JSON(400, gin.H{
			"error": "movie id is required",
		})
		return
	}
	showtimes , err := userUseCase.GetMovieShowTime(movieid)
	if err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200,showtimes)
}

// ReserveForMovie implements UserController.
func (u *usercontroller) ReserveForMovie(c *gin.Context) {
	c.Header("Content-Type", "application/json")
	showtime := c.Param("showtimeid")
	type Seat struct{
		SeatPlace string `json:"seat"`
	}
	var seat Seat

	if err := c.ShouldBind(&seat); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	if showtime == "" {
		c.JSON(400, gin.H{
			"error": "showtime id is required",
		})
		return
	}
	user, err := c.Get("client")
	if !err {
		c.JSON(400, gin.H{
			"error": "user not found",
		})
		return
	}
	newSeat,er := userUseCase.ReserveForMovie(showtime, user.(*token.UserReg).ID,seat.SeatPlace)
	if er != nil {
		c.JSON(400, gin.H{
			"error": er.Error(),
		})
		return
	}
	c.JSON(200, gin.H{"message": "success","seat":newSeat})
}

// Login implements UserController.
func (u *usercontroller) Login(c *gin.Context) {
	c.Header("Content-Type", "application/json")
	var Temp struct {
		Email    string `json:"email" validate:"required,email"`
		Password string `json:"password" validate:"required,min=6"`
	}

	if err := c.ShouldBind(&Temp); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}

	if err := validate.Struct(Temp); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	token, err := userUseCase.Login(Temp.Email, Temp.Password)
	if err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	token.Password = ""
	c.JSON(200,token)

}

// Register implements UserController.
func (u *usercontroller) Register(c *gin.Context) {
	c.Header("Content-Type", "application/json")
	var user models.User
	if err := c.ShouldBind(&user); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}

	if err := validate.Struct(user); err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	user.UserID = primitive.NewObjectID()
	err := userUseCase.Register(&user)
	if err != nil {
		c.JSON(400, gin.H{
			"error": err.Error(),
		})
		return
	}
	c.JSON(200, gin.H{"message": "success"})

}

func NewUserController(userusercase usercase.UserUsecase) UserController {
	userUseCase = userusercase
	return &usercontroller{}
}
