package database

import (
	"context"
	"errors"
	"fmt"
	"movie/models"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
)

var (
	MoviesData    = GetData(Client, "movies")
	UsersData     = GetData(Client, "users")
	HallData      = GetData(Client, "hall")
	MovieShowTime = GetData(Client, "movieshowtime")
)

func RegisterUser(user *models.User) error {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	_, inserErr := UsersData.InsertOne(ctx, user)
	if inserErr != nil {
		return inserErr
	}
	return nil
}

func Login(email string) (*models.User, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	var foundUser models.User
	err := UsersData.FindOne(ctx, bson.M{"email": email}).Decode(&foundUser)
	if err != nil {
		return nil, errors.New("user not found")
	}
	return &foundUser, nil
}

func AddMovie(movie *models.Movie) error {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	_, inserErr := MoviesData.InsertOne(ctx, movie)
	if inserErr != nil {
		return inserErr
	}
	return nil
}

func AddHall(hall *models.Hall) error {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	_, inserErr := HallData.InsertOne(ctx, hall)
	if inserErr != nil {
		return inserErr
	}
	return nil
}

func ChangeUserRole(email string, role string) error {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	_, err := UsersData.UpdateOne(ctx, bson.M{"email": email}, bson.M{"$set": bson.M{"role": role}})
	if err != nil {
		return err
	}
	return nil
}

func DeleteMovie(movieID string) error {
	movieid, err := primitive.ObjectIDFromHex(movieID)
	if err != nil {
		return err
	}

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	_, err = MoviesData.DeleteOne(ctx, bson.M{"movieid": movieid})
	if err != nil {
		return err
	}
	return nil
}

func RemoveHall(hallID string) error {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	hallid, err := primitive.ObjectIDFromHex(hallID)
	if err != nil {
		return err
	}

	_, err = HallData.DeleteOne(ctx, bson.M{"hallid": hallid})
	if err != nil {
		return err
	}
	return nil
}

func UpdateMovie(movie *models.Movie, movieID string) error {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	var existingMovie models.Movie
	movieid, err := primitive.ObjectIDFromHex(movieID)
	if err != nil {
		return err
	}
	err = MoviesData.FindOne(ctx, bson.M{"movieid": movieid}).Decode(&existingMovie)
	if err != nil {
		return err
	}

	updateFields := bson.M{}

	if movie.Title != nil {
		updateFields["title"] = movie.Title
	}
	if movie.Year != nil {
		updateFields["year"] = movie.Year
	}
	if movie.Genre != nil {
		updateFields["genre"] = movie.Genre
	}
	if movie.Duration != nil {
		updateFields["duration"] = movie.Duration
	}
	if movie.Poster != nil {
		updateFields["poster"] = movie.Poster
	}
	if movie.Trailer != nil {
		updateFields["trailer"] = movie.Trailer
	}
	if movie.Description != nil {
		updateFields["description"] = movie.Description
	}

	if len(movie.Cast) > 0 {
		updateFields["cast"] = movie.Cast
	} else {
		updateFields["cast"] = existingMovie.Cast
	}

	if len(movie.Crew.Director) > 0 {
		updateFields["crew.director"] = movie.Crew.Director
	} else {
		updateFields["crew.director"] = existingMovie.Crew.Director
	}
	if len(movie.Crew.Producer) > 0 {
		updateFields["crew.producer"] = movie.Crew.Producer
	} else {
		updateFields["crew.producer"] = existingMovie.Crew.Producer
	}
	if len(movie.Crew.Writer) > 0 {
		updateFields["crew.writer"] = movie.Crew.Writer
	} else {
		updateFields["crew.writer"] = existingMovie.Crew.Writer
	}
	if len(movie.Crew.CameraMan) > 0 {
		updateFields["crew.cameraMan"] = movie.Crew.CameraMan
	} else {
		updateFields["crew.cameraMan"] = existingMovie.Crew.CameraMan
	}

	_, err = MoviesData.UpdateOne(ctx, bson.M{"movieid": movieid}, bson.M{"$set": updateFields})
	if err != nil {
		return err
	}
	return nil
}

func UpdateHall(hall *models.Hall, hallID string) error {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	var existingHall models.Hall
	hallid, err := primitive.ObjectIDFromHex(hallID)
	if err != nil {
		return err
	}
	err = HallData.FindOne(ctx, bson.M{"hallid": hallid}).Decode(&existingHall)
	if err != nil {
		return err
	}

	updateFields := bson.M{}

	if hall.Name != nil {
		updateFields["name"] = hall.Name
	}
	if hall.Location != nil {
		updateFields["location"] = hall.Location
	}
	if hall.Rows != nil {
		updateFields["rows"] = hall.Rows
	}
	if hall.Seats != nil {
		updateFields["seats"] = hall.Seats
	}

	_, err = HallData.UpdateOne(ctx, bson.M{"hallid": hallid}, bson.M{"$set": updateFields})
	if err != nil {
		return err
	}
	return nil
}

func AddShowtime(showTime models.ShowTime) error {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	var hall models.Hall
	hallid,err := primitive.ObjectIDFromHex(showTime.HallID)
	if err != nil{
		return err
	}
	err = HallData.FindOne(ctx, bson.M{"hallid": hallid}).Decode(&hall)
	if err != nil {
		return errors.New("hall does not exist")
	}
	for i, seats := range *hall.Rows {
		for j := 0; j < seats; j++ {
			seatLabel := fmt.Sprintf("%d%c", i+1, 'a'+j)
			showTime.AvailableSeats = append(showTime.AvailableSeats, seatLabel)
		}
	}

	_, err = MovieShowTime.InsertOne(ctx, showTime)
	if err != nil {
		return err
	}
	return nil
}

func DeleteShowTime(showtimeID string) error {

	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	showtimeid, err := primitive.ObjectIDFromHex(showtimeID)
	if err != nil {
		return err
	}
	_, err = MovieShowTime.DeleteOne(ctx, bson.M{"showtimeid": showtimeid})
	if err != nil {
		return err
	}
	return nil
}

func TakeSeat(seat string, showtimeID string, userID string) (bool, *string,error) {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	// Check if the showtime exists
	check, showtime, err := ShowTimeExists(showtimeID)
	if err != nil {
		
		return false,nil,err
	}

	if !check {
		return false,nil,errors.New("showTime doesn't exist") // ShowTime doesn't exist
	}

	if len(showtime.AvailableSeats) == 0 {
		
		return false, nil,errors.New("no available seats") // No seats available
	}
	if _, exists := showtime.TakenSeats[seat]; exists {
		return false, nil, errors.New("seat already taken")
	}
    var newSeat string
	// If a specific seat is specified
	if seat != "" {
		// Check if the seat is available
		for i, availableSeat := range showtime.AvailableSeats {
			if availableSeat == seat {
				// Remove the seat from available seats
				showtime.AvailableSeats = append(showtime.AvailableSeats[:i], showtime.AvailableSeats[i+1:]...)
				// Add the seat to taken seats
				showtime.TakenSeats[seat] = userID
				newSeat = seat
				break
			}
		}
	} else {
		// If no specific seat is specified, take the first available seat
		if len(showtime.AvailableSeats) > 0 {
			seat = showtime.AvailableSeats[0] // Take the first available seat
			// Remove the seat from available seats
			showtime.AvailableSeats = showtime.AvailableSeats[1:] // Remove first element
			// Add the seat to taken seats
			showtime.TakenSeats[seat] = userID
			newSeat = seat
		} else {
			return false, nil,errors.New("no available seats") // No seats available
		}
	}

	// Update the database with the new state of available and taken seats
	showtimeObjectID, err := primitive.ObjectIDFromHex(showtimeID)
	if err != nil {
		return false, nil,err
	}

	// Prepare the update document
	update := bson.M{
		"$set": bson.M{
			"availableSeats": showtime.AvailableSeats,
			"takenSeats":     showtime.TakenSeats,
		},
	}

	_, err = MovieShowTime.UpdateOne(
		ctx,
		bson.M{"showtimeid": showtimeObjectID},
		update,
	)

	if err != nil {
		return false,nil, err
	}

	return true, &newSeat,nil
}

func CancelReservation(showtimeid string, userid string, seat string) error {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	showtimeObjectID, err := primitive.ObjectIDFromHex(showtimeid)
	if err != nil {
		return err
	}
	var showtime models.ShowTime
	err = MovieShowTime.FindOne(ctx, bson.M{"showtimeid": showtimeObjectID}).Decode(&showtime)
	if err != nil {
		return err
	}
	if showtime.TakenSeats[seat] != userid {
		return errors.New("seat not taken by user")
	}
	delete(showtime.TakenSeats, seat)
	showtime.AvailableSeats = append(showtime.AvailableSeats, seat)

	update := bson.M{
		"$set": bson.M{
			"availableSeats": showtime.AvailableSeats,
			"takenSeats":     showtime.TakenSeats,
		},
	}

	// Perform the update operation
	_, err = MovieShowTime.UpdateOne(
		ctx,
		bson.M{"showtimeid": showtimeObjectID},
		update,
	)

	if err != nil {
		return err
	}

	return nil

}

func ChangeSeat(showtimeid string, userid string, newseat string, oldseat string) error {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	showtimeObjectID, err := primitive.ObjectIDFromHex(showtimeid)
	if err != nil {
		return err
	}
	var showtime models.ShowTime
	err = MovieShowTime.FindOne(ctx, bson.M{"showtimeid": showtimeObjectID}).Decode(&showtime)
	if err != nil {
		return err
	}
	if showtime.TakenSeats[oldseat] != userid {
		return errors.New("seat not taken by user")
	}
	delete(showtime.TakenSeats, oldseat)
	for i, availableSeat := range showtime.AvailableSeats {
		if availableSeat == newseat {
			// Remove the seat from available seats
			showtime.AvailableSeats = append(showtime.AvailableSeats[:i], showtime.AvailableSeats[i+1:]...)
			showtime.AvailableSeats = append(showtime.AvailableSeats, oldseat)
			// Add the seat to taken seats
			showtime.TakenSeats[newseat] = userid
			break
		}
	}

	update := bson.M{
		"$set": bson.M{
			"availableSeats": showtime.AvailableSeats,
			"takenSeats":     showtime.TakenSeats,
		},
	}

	// Perform the update operation
	_, err = MovieShowTime.UpdateOne(
		ctx,
		bson.M{"showtimeid": showtimeObjectID},
		update,
	)

	if err != nil {
		return err
	}

	return nil

}

func GetAllMovies() ([]models.Movie, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	var movies []models.Movie
	cursor, err := MoviesData.Find(ctx, bson.M{})
	if err != nil {
		return nil, err
	}
	defer cursor.Close(ctx)
	for cursor.Next(ctx) {
		var movie models.Movie
		cursor.Decode(&movie)
		movies = append(movies, movie)
	}
	return movies, nil
}

func GetMovieByFilter(title string, genre string, year string) ([]models.Movie, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	filter := bson.M{}
	if title != "" {
		filter["title"] = title
	}
	if genre != "" {
		filter["genre"] = genre
	}
	if year != "" {
		filter["year"] = year
	}

	var movies []models.Movie
	cursor, err := MoviesData.Find(ctx, filter)
	if err != nil {
		return nil, err
	}
	defer cursor.Close(ctx)
	for cursor.Next(ctx) {
		var movie models.Movie
		cursor.Decode(&movie)
		movies = append(movies, movie)
	}
	return movies, nil
}

func GetAllShowTime() ([]models.ShowTime, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	var showtimes []models.ShowTime
	cursor, err := MovieShowTime.Find(ctx, bson.M{})
	if err != nil {
		return nil, err
	}
	defer cursor.Close(ctx)
	for cursor.Next(ctx) {
		var showtime models.ShowTime
		cursor.Decode(&showtime)
		showtimes = append(showtimes, showtime)
	}
	return showtimes, nil
}

func GetMovieShowTime(movieid string) ([]models.ShowTime, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	
	var showtimes []models.ShowTime
	cursor, err := MovieShowTime.Find(ctx, bson.M{"movieid": movieid})
	if err != nil {
		return nil, err
	}
	defer cursor.Close(ctx)
	for cursor.Next(ctx) {
		var showtime models.ShowTime
		cursor.Decode(&showtime)
		showtimes = append(showtimes, showtime)
	}
	return showtimes, nil
}
