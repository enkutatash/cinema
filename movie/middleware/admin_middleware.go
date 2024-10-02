package middleware

import (
	"movie/token"
	"net/http"

	"strings"

	"github.com/gin-gonic/gin"
)
func AuthenticateAdmin() gin.HandlerFunc {
    return func(c *gin.Context) {
		clientToken := c.Request.Header.Get("Authorization")
		if clientToken ==""{
			c.JSON(http.StatusUnauthorized, gin.H{"error": "No token provided"})			
			c.Abort()
			return
		}
		splitToken := strings.Split(clientToken, "Bearer ")
		if len(splitToken) != 2 {
            c.JSON(http.StatusUnauthorized, gin.H{"error":"Invalid token"})
            c.Abort()
            return
        }
		clientToken = splitToken[1]

        claims, err := token.ValidateToken(clientToken)
        if err != "" {
            c.JSON(http.StatusUnauthorized, gin.H{"error":"Invalid token"})
            c.Abort()
            return
        }
		userRole := claims.Role 
        if userRole != "admin" {
            c.JSON(http.StatusUnauthorized, gin.H{"error": "Unauthorized"})
            c.Abort()
            return
        }
		c.Next()
    }
}