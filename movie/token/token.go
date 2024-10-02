package token

import (
	"fmt"
	"os"
	"time"

	"github.com/dgrijalva/jwt-go"
)

type UserReg struct {
	ID       string
	FullName string
	Email    string
	Password string
	Role     string
	jwt.StandardClaims
}
var Secret_key = os.Getenv("SECRET_KEY")
func GenerateToken(email string, fullName string, uid string, Role string) (string,error) {
	claim := &UserReg{
		Email:    email,
		FullName: fullName,
		ID:       uid,
		Role:     Role,
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: time.Now().Local().AddDate(1, 0, 0).Unix(),
		},
	}
	token, err := jwt.NewWithClaims(jwt.SigningMethodHS256, claim).SignedString([]byte(Secret_key))
	if err != nil {
		return "",  fmt.Errorf("error in generating token: %v", err)
	}
	return token, nil
}


func ValidateToken(signedtoken string) (claim *UserReg, msg string) {

	token, err := jwt.ParseWithClaims(signedtoken, &UserReg{}, func(token *jwt.Token) (interface{}, error) {
		return []byte(Secret_key), nil
	})

	if err != nil {
		msg = err.Error()
		return
	}
	claim, ok := token.Claims.(*UserReg)
	if !ok {
		msg = "Invalid token"

	}

	return claim, msg
}