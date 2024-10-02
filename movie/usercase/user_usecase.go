package usercase

import (
	"errors"
	"log"
	"movie/database"
	"movie/models"
	"movie/token"

	"golang.org/x/crypto/bcrypt"
)

type UserUsecase interface {
	GetAllMovie() ([]models.Movie, error)
	GetMovieByFilter(title string,genre string,year string) (movies []models.Movie, err error)
	GetAllShowTime() ([]models.ShowTime, error)
	GetMovieShowTime(movieid string) ([]models.ShowTime, error)
	ReserveForMovie(showtimeid string, userid string, seat string) (*string,error)
	CancelReservation(showtimeid string, userid string, seat string) error
	ChangeSeat(showtimeid string, userid string, newseat string, oldseat string) error
	Register(user *models.User) error
	Login(email, password string) (*models.User, error)
}

type userusecase struct{}

// GetAllShowTime implements UserUsecase.
func (u *userusecase) GetAllShowTime() ([]models.ShowTime, error) {
	return database.GetAllShowTime()
}

// GetMovieShowTime implements UserUsecase.
func (u *userusecase) GetMovieShowTime(movieid string) ([]models.ShowTime, error) {
	return database.GetMovieShowTime(movieid)
}

// ChangeSeat implements UserUsecase.
func (u *userusecase) ChangeSeat(showtimeid string, userid string, newseat string, oldseat string) error {
	check, err := database.CheckValidSeat(newseat, showtimeid)
	if err != nil {
		return err
	}
	if !check {
		return errors.New("invalid seat")
	}

	err = database.ChangeSeat(showtimeid, userid, newseat, oldseat)
	if err != nil {
		return err
	}
	return nil

}

func HashPassword(password string) string {
	hashed, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	if err != nil {
		log.Panic(err)
	}
	return string(hashed)
}

func VerifyPassword(hashedPassword, password string) bool {
	bcryptErr := bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(password))
	return bcryptErr == nil

}

// CancelReservation implements UserUsecase.
func (u *userusecase) CancelReservation(showtimeid string, userid string, seat string) error {
	err := database.CancelReservation(showtimeid, userid, seat)
	if err != nil {
		return err
	}
	return nil
}

// GetAllMovie implements UserUsecase.
func (u *userusecase) GetAllMovie() (movies []models.Movie, err error) {
	return database.GetAllMovies()
}

// GetMovieByFilter implements UserUsecase.
func (u *userusecase) GetMovieByFilter(title string,genre string,year string) (movies []models.Movie, err error) {
	return database.GetMovieByFilter(title,genre,year)
}

// Login implements UserUsecase.
func (u *userusecase) Login(email string, password string) (*models.User, error) {
	foundUser, err := database.Login(email)
	if err != nil {
		return nil, err
	}

	if !VerifyPassword(foundUser.Password, password) {
		return nil, errors.New("invalid password")
	}
	return foundUser, nil
}

// Register implements UserUsecase.
func (u *userusecase) Register(user *models.User) error {
	uid := user.UserID.Hex()
	token, err := token.GenerateToken(user.Email, user.FullName, uid, user.Role)
	if err != nil {
		return err
	}
	user.Token = token
	validEmail := database.EmailExists(user.Email)
	if validEmail {
		return errors.New("email already exists")
	}
	user.Password = HashPassword(user.Password)
	if user.Role == ""{
		user.Role = "user"
	}
	err = database.RegisterUser(user)
	if err != nil {
		return err
	}
	return nil

}

// ReserveForMovie implements UserUsecase.
func (u *userusecase) ReserveForMovie(showtimeid string, userid string, seat string) (*string,error) {
	check,newSeat,err:= database.TakeSeat(seat,showtimeid,userid)
	if err != nil {
		return nil,err
	}
	if !check {
		return nil,errors.New("seat is already taken")
	}
	return newSeat,nil
}

func NewUserUsecase() UserUsecase {
	return &userusecase{}
}
