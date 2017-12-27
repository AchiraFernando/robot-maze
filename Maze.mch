/* Coursework01
 * Author: Achira Fernando
 * Creation date: 12/22/2017
 */
MACHINE
    Maze
    
SETS
    OUTPUT_MESSAGE = {Yes, No}

CONSTANTS

    EntranceSquare,
    ExitSquare,
    xAxis,
    yAxis,
    Barriers

PROPERTIES
    
    xAxis <: NATURAL1 &
    xAxis = 1..7 &
    yAxis <: NATURAL1 &
    yAxis = 1..5 &
    EntranceSquare: NATURAL1 <-> NATURAL1 &
    EntranceSquare = {(1 |-> 1)} &
    ExitSquare: NATURAL1 <-> NATURAL1 &
    ExitSquare = {(1 |-> 5)} & 
    Barriers: NATURAL1 <-> NATURAL1 &
    Barriers = {(1 |-> 3), (2 |-> 1), (2 |-> 3), (2 |-> 5), (3 |-> 3), (4 |-> 2), (4 |-> 3), (4 |-> 4), (6 |-> 1), (6 |-> 2), (6 |-> 4), (7 |-> 4)}

VARIABLES

    xVisited,
    yVisited,
    visitedRoute

INVARIANT
    
    xVisited: NATURAL &
    yVisited: NATURAL &
    visitedRoute: seq(INTEGER * INTEGER)

INITIALISATION
    
    visitedRoute := [] ||
    xVisited := 0 ||
    yVisited := 0

OPERATIONS

//Update all

   updateAll(xAxiss, yAxiss, route)  =
   PRE
       xAxiss: NATURAL1 & yAxiss: NATURAL1 & route: seq(INTEGER * INTEGER)    
   THEN
       visitedRoute := route ||
       xVisited := xAxiss ||
       yVisited := yAxiss
   END;
   
//Check if the robot has reached the exit

   exitFound  <-- foundExit  =
   IF
       ((xVisited |-> yVisited) : ExitSquare) 
   THEN
       exitFound := Yes
   ELSE
       exitFound := No
   END;

//Get the visited square position on the maze

   isVisited  <-- visitedSquare(xPoint, yPoint)  =
   PRE    
       xPoint : xAxis &
       yPoint : yAxis
   THEN
       IF
           (xPoint |-> yPoint : ran(visitedRoute)) 
       THEN
           isVisited := Yes
       ELSE
           isVisited := No
       END
   END;

//Get the robot's route through the maze

   route  <-- getRoute  =
   BEGIN 
       route := visitedRoute
   END
   
END





