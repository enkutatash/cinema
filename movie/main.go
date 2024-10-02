package main

import (
	"movie/controller"
	"movie/routes"
	"movie/usercase"
	"os"

	"github.com/gin-gonic/gin"
)

var(
	userusercase usercase.UserUsecase = usercase.NewUserUsecase()
	usercontroller controller.UserController = controller.NewUserController(userusercase)
)

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	route := gin.New()
	route.Use(gin.Logger())
	route.POST("/login", usercontroller.Login)
	route.POST("/register", usercontroller.Register)
	routes.UserRoute(route)
	routes.AdminRoute(route)
	route.Run(":" + port)
}