package database

import (
	"context"
	"errors"

	"movie/models"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
)

func EmailExists(email string) bool {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	count, err := UsersData.CountDocuments(ctx, bson.M{"email": email})
	if err != nil {
		return false
	}
	return count > 0
}

func MovieExists(movieID string) bool {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	movieid ,err := primitive.ObjectIDFromHex(movieID)
	if err != nil{
		return false
	}

	count, err := MoviesData.CountDocuments(ctx, bson.M{"movieid": movieid})
	if err != nil {
		return false
	}
	return count > 0
}

func HallExists(hallID string) bool {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	hallid, err := primitive.ObjectIDFromHex(hallID)
	if err != nil{
		return false
	}

	count, err := HallData.CountDocuments(ctx, bson.M{"hallid": hallid})
	if err != nil {
		return false
	}
	
	return count > 0
}

func CheckTime(movieID string, hallID string, startTime time.Time) (bool,*time.Time, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	var movie models.Movie
	movieid ,err := primitive.ObjectIDFromHex(movieID)
	if err != nil{
		return false,nil, err
	}
	err = MoviesData.FindOne(ctx, bson.M{"movieid": movieid}).Decode(&movie)
	if err != nil {
		return false, nil,err
	}
	duration,err  := time.ParseDuration(*movie.Duration)
	if err != nil{
		return false,nil, err
	}
	endTime := startTime.Add(time.Duration(duration) * time.Minute)

	hallid, err := primitive.ObjectIDFromHex(hallID)
	if err != nil {
		return false, nil,err
	}
	cursor, err := MovieShowTime.Find(ctx, bson.M{"hallid": hallid})
	if err != nil {
		return false, nil,err
	}
	if cursor.RemainingBatchLength() == 0 {
		return true, &endTime, nil
	}
	defer cursor.Close(ctx) 
	for cursor.Next(ctx) {
		var showTime models.ShowTime
		if err := cursor.Decode(&showTime); err != nil {
			return false, nil,err 
		}
		if (startTime.Before(showTime.TimeEnd) && endTime.After(showTime.TimeStart)) {
          
            return false, nil,nil
        }
	}
	if err := cursor.Err(); err != nil {
		return false, nil,err 
	}
	return true,&endTime, nil
}


func ShowTimeExists(showTimeID string) (bool, *models.ShowTime, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	showtimeid, err := primitive.ObjectIDFromHex(showTimeID)
	if err != nil {
		
		return false, nil, err
	}

	filter := bson.M{"showtimeid": showtimeid}

	var showTime models.ShowTime

	err = MovieShowTime.FindOne(ctx, filter).Decode(&showTime)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			
			return false, nil, nil
		}
		
		return false, nil, err
	}
	
	return true, &showTime, nil
}




func CheckValidSeat(seat string , showTime string)(bool, error){
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	// Check if the showtime exists
	showTimeID , err:= primitive.ObjectIDFromHex(showTime)
	if err != nil{
		return false,err
	}

	var showtime models.ShowTime
	err = MovieShowTime.FindOne(ctx, bson.M{"showtimeid": showTimeID}).Decode(&showtime)
	if err != nil {
		if err == mongo.ErrNoDocuments {
			return false, errors.New("showtime not found")
		}
		return false, err
	}
	for _, availableSeat := range showtime.AvailableSeats {
		if availableSeat == seat {
			return true, nil
		}
	}

	if _, exists := showtime.TakenSeats[seat]; exists {
		return false, errors.New("seat is already taken")
	}

	return false, errors.New("invalid seat") 
}