package routes

import (
	"movie/controller"
	"movie/middleware"
	"movie/usercase"

	"github.com/gin-gonic/gin"
)

var(
	adminUsecase usercase.AdminUseCase = usercase.NewAdminUseCase()
	adminController controller.AdminController = controller.NewAdminController(adminUsecase)
)
func AdminRoute(incomingRoute *gin.Engine) {
	adminRoute := incomingRoute.Group("/admin")
	adminRoute.Use(middleware.AuthenticateAdmin())
	{
		adminRoute.POST("/movie",adminController.AddMovie) 
		adminRoute.PUT("/movie/:movieid",adminController.UpdateMovie) 
		adminRoute.DELETE("/movie/:movieid",adminController.DeleteMovie) 

		adminRoute.POST("schedule",adminController.AddShowtime) 
		adminRoute.PUT("/schedule/:showtimeid",adminController.RescheduleMovie) 
		adminRoute.DELETE("/schedule/:showtimeid",adminController.DeleteShowTime) 

		adminRoute.POST("/hall",adminController.AddHall) 
		adminRoute.PUT("/hall/:hallid",adminController.UpdateHall) 
		adminRoute.DELETE("/hall/:hallid",adminController.RemoveHall) 

		adminRoute.PUT("/user_assign",adminController.ChangeUserRole) 
	}
}
