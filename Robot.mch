/* Coursework01
 * Author: Achira Fernando
 * Creation date: 12/22/2017
 */
MACHINE
    Robot

INCLUDES
    Maze
    
PROMOTES
    foundExit, visitedSquare, getRoute
    
SETS
    DIRECTIONS = {
        North, 
        South, 
        East, 
        West
    };

    TOAST_MESSAGE = {
        MoveSuccessful, 
        CannotMoveInternalWallDetected, 
        CannotMoveExternalWallDetected, 
        TeleportSuccessful,
        CannotTeleportToExitOnStart,
        CannotTeleportToInternalWalls
    }
    
VARIABLES

    visitedDirection,
    visitedPath,
    xPosition,
    yPosition
        
INVARIANT
    
    visitedDirection: seq(DIRECTIONS) &
    visitedPath: seq(INTEGER * INTEGER) &
    xPosition: NATURAL1 &
    yPosition:NATURAL1 &
    xPosition: xAxis &
    yPosition: yAxis
    
INITIALISATION
    
    visitedDirection := [] ||
    visitedPath := [] ||
    xPosition := 1 ||
    yPosition := 1

OPERATIONS

//Moving to North 

   message  <-- moveNorth  =
    IF
        ((xPosition|-> yPosition  + 1 ) /: Barriers & 
        (yPosition + 1 : yAxis))
    THEN
        yPosition := yPosition + 1 ||
        visitedDirection := visitedDirection <- North ||
        visitedPath := visitedPath <- (xPosition |-> yPosition) ||
        updateAll(xPosition, yPosition +1, visitedPath <- (xPosition  |-> yPosition)) ||
        message := MoveSuccessful
    ELSIF
        (yPosition +1 /:  yAxis)
	      THEN 
	          message := CannotMoveExternalWallDetected
	 ELSE 
	     message := CannotMoveInternalWallDetected
    END;

//Moving to South 

   message  <-- moveSouth  =
    IF
        ((xPosition |-> yPosition -1) /: Barriers & 
        (yPosition - 1 :  yAxis))
    THEN
        yPosition := yPosition - 1 ||
        visitedDirection := visitedDirection <- South ||
        visitedPath := visitedPath <- (xPosition |-> yPosition) ||
        updateAll(xPosition, yPosition -1, visitedPath <- (xPosition  |-> yPosition)) ||
        message := MoveSuccessful
    ELSIF
        (yPosition - 1 /:  yAxis)
	      THEN 
	          message := CannotMoveExternalWallDetected
	 ELSE 
	     message := CannotMoveInternalWallDetected
    END;

//Moving to East 

   message  <-- moveEast  =
    IF
        ((xPosition +1  |-> yPosition) /: Barriers & 
        (xPosition + 1 : xAxis))
    THEN
        xPosition := xPosition + 1 ||
        visitedDirection := visitedDirection <- East ||
        visitedPath := visitedPath <- (xPosition  |-> yPosition) ||
        updateAll(xPosition + 1, yPosition, visitedPath <- (xPosition  |-> yPosition)) ||
        message := MoveSuccessful
    ELSIF
        (xPosition + 1 /:  xAxis)
	      THEN 
	          message := CannotMoveExternalWallDetected
	 ELSE 
	     message := CannotMoveInternalWallDetected
    END;
    
//Moving to West 

   message  <-- moveWest  =
    IF
        ((xPosition  - 1 |-> yPosition) /: Barriers & 
        (xPosition - 1 : xAxis))
    THEN
        xPosition := xPosition - 1 ||
        visitedDirection := visitedDirection <- West ||
        visitedPath := visitedPath <- (xPosition |-> yPosition) ||
        updateAll(xPosition - 1, yPosition, visitedPath <- (xPosition  |-> yPosition)) ||
        message := MoveSuccessful
    ELSIF
        (xPosition - 1 /: xAxis)
	      THEN 
	          message := CannotMoveExternalWallDetected
	 ELSE 
	     message := CannotMoveInternalWallDetected
    END;
    
//Get the current position on the maze

   currentPosition  <-- getPosition  =
   BEGIN 
       currentPosition := (xPosition, yPosition)
   END;

//Teleportation

   teleportMessage  <-- teleport(xPoint, yPoint)  =
   PRE
       xPoint : xAxis &
       yPoint : yAxis 
   THEN
       IF
           ((xPoint |-> yPoint) /: Barriers &
            ((xPoint |-> yPoint) /: ExitSquare or
            (xPosition |-> yPosition) /: EntranceSquare))
       THEN
           xPosition := xPoint ||
           yPosition := yPoint ||
           teleportMessage := TeleportSuccessful ||
		     visitedPath := visitedPath <- (xPosition |-> yPosition) ||
		     updateAll(xPoint, yPoint, visitedPath <- (xPosition  |-> yPosition))
       ELSE IF
               ((xPoint |-> yPoint) : Barriers)
           THEN
               teleportMessage := CannotTeleportToInternalWalls
       ELSE
            teleportMessage := CannotTeleportToExitOnStart
    
           END
       END
   END
   
END





