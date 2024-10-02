package usercase

import (
	"errors"
	
	"movie/database"
	"movie/models"
)

type AdminUseCase interface {
	AddHall(hall *models.Hall) error
	AddMovie(movie *models.Movie) error
	ChangeUserRole(email string, role string) error
	RemoveHall(hallID string) error
	DeleteMovie(movieID string) error
	UpdateHall(hall *models.Hall, id string) error
	UpdateMovie(movie *models.Movie, id string) error

	AddShowtime(showtime *models.ShowTime) error
	DeleteShowTime(showtimeID string) error
	RescheduleMovie(showtime *models.ShowTime, showtimeid string) error
}

type adminusecase struct{}

// RescheduleMovie implements AdminUseCase.
func (a *adminusecase) RescheduleMovie(showtime *models.ShowTime, showtimeid string) error {
	
	check,oldshowtime, err := database.ShowTimeExists(showtimeid)
	if err != nil{
		return err
	}
	if !check {
		return errors.New("showtime does not exist")
	}
	err = database.DeleteShowTime(oldshowtime.ShowTimeID.Hex())
	if err != nil {
		return err
	}
	check, _,err = database.CheckTime(showtime.MovieID, showtime.HallID, showtime.TimeStart)
	if err != nil {
		database.AddShowtime(*oldshowtime)
		return errors.New("error checking time")
	}
	if !check {
		database.AddShowtime(*oldshowtime)
		return errors.New("time clash")
	}

	return database.AddShowtime(*showtime)

}

// DeleteShowTime implements AdminUseCase.
func (a *adminusecase) DeleteShowTime(showtimeID string) error {
	return database.DeleteShowTime(showtimeID)
}

// AddShowtime implements AdminUseCase.
func (a *adminusecase) AddShowtime(showtime *models.ShowTime) error {
	if !database.MovieExists(showtime.MovieID) {
		return errors.New("movie does not exist")
	}
	if !database.HallExists(showtime.HallID) {
		return errors.New("hall does not exist")
	}
	check, endTime,err := database.CheckTime(showtime.MovieID, showtime.HallID, showtime.TimeStart)
	if err != nil {
		return err
	}
	if !check {
		return errors.New("time clash")
	}
	showtime.TimeEnd = *endTime
	return database.AddShowtime(*showtime)
}

// UpdateHall implements AdminUseCase.
func (a *adminusecase) UpdateHall(hall *models.Hall, id string) error {
	if !database.HallExists(id) {
		return errors.New("hall does not exist")
	}
	return database.UpdateHall(hall, id)
}

// UpdateMovie implements AdminUseCase.
func (a *adminusecase) UpdateMovie(movie *models.Movie, id string) error {
	if !database.MovieExists(id) {
		return errors.New("movie does not exist")
	}
	return database.UpdateMovie(movie, id)
}

// DeleteMovie implements AdminUseCase.
func (a *adminusecase) DeleteMovie(movieID string) error {
	if !database.MovieExists(movieID) {
		return errors.New("movie does not exist")
	}
	return database.DeleteMovie(movieID)
}

// RemoveHall implements AdminUseCase.
func (a *adminusecase) RemoveHall(hallID string) error {
	if !database.HallExists(hallID) {
		return errors.New("hall does not exist")
	}
	return database.RemoveHall(hallID)
}

// ChangeUserRole implements AdminUseCase.
func (a *adminusecase) ChangeUserRole(email string, role string) error {
	validEmail := database.EmailExists(email)
	if !validEmail {
		return errors.New("email does not exist")
	}
	return database.ChangeUserRole(email, role)

}

// AddMovie implements AdminUseCase.
func (a *adminusecase) AddMovie(movie *models.Movie) error {
	return database.AddMovie(movie)
}

// AddHall implements AdminUseCase.
func (a *adminusecase) AddHall(hall *models.Hall) error {
	return database.AddHall(hall)
}

func NewAdminUseCase() AdminUseCase {
	return &adminusecase{}
}
