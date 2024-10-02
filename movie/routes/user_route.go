package routes

import (
	"movie/controller"
	"movie/middleware"
	"movie/usercase"

	"github.com/gin-gonic/gin"
)

var (
  userusercase usercase.UserUsecase = usercase.NewUserUsecase()
  userController controller.UserController = controller.NewUserController(userusercase)
)
func UserRoute(incomingRoute *gin.Engine) {
  userroute := incomingRoute.Group("/user")
  userroute.Use(middleware.UserMiddleWare())
  {
    userroute.GET("/movie",userController.GetAllMovie) 
    // userroute.GET("/movie/:id",userController.GetMovieByid)
    userroute.GET("/movie/filter",userController.GetMovieByFilter) 
    userroute.GET("/movie/showtime",userController.GetAllSHowTime)
    userroute.GET("/movie/showtime/:movieid",userController.GetMovieShowTime) 

    userroute.POST("/showtime/:showtimeid",userController.ReserveForMovie)  
    userroute.DELETE("/showtime/:showtimeid",userController.CancelReservation)  
    userroute.PUT("/showtime/:showtimeid",userController.ChangeSeat) 

	
  }
}