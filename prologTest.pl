neighbour('FrontRoomB3','FrontRoomB2').
neighbour('FrontRoomB2','FrontRoomB3').
neighbour('DropZone','FrontDropZone').
neighbour('FrontDropZone','DropZone').
neighbour('LeftHallC','LeftHallD').
neighbour('LeftHallD','LeftHallC').
neighbour('FrontDropZone','RightHallD').
neighbour('RightHallD','FrontDropZone').
neighbour('FrontDropZone','LeftHallD').
neighbour('LeftHallD','FrontDropZone').
neighbour('FrontRoomC3','RightHallC').
neighbour('RightHallC','FrontRoomC3').
neighbour('FrontRoomC2','FrontRoomC3').
neighbour('FrontRoomC3','FrontRoomC2').
neighbour('RoomA1','FrontRoomA1').
neighbour('FrontRoomA1','RoomA1').
neighbour('RoomC1','FrontRoomC1').
neighbour('FrontRoomC1','RoomC1').
neighbour('FrontRoomA3','RoomA3').
neighbour('RoomA3','FrontRoomA3').
neighbour('FrontRoomB1','RoomB1').
neighbour('RoomB1','FrontRoomB1').
neighbour('FrontRoomC1','FrontRoomC2').
neighbour('FrontRoomC2','FrontRoomC1').
neighbour('FrontRoomA2','FrontRoomA3').
neighbour('FrontRoomA3','FrontRoomA2').
neighbour('FrontRoomA2','FrontRoomA1').
neighbour('FrontRoomA1','FrontRoomA2').
neighbour('LeftHallB','LeftHallC').
neighbour('LeftHallC','LeftHallB').
neighbour('LeftHallB','FrontRoomB1').
neighbour('FrontRoomB1','LeftHallB').
neighbour('FrontRoomB2','FrontRoomB1').
neighbour('FrontRoomB1','FrontRoomB2').
neighbour('FrontRoomB3','RoomB3').
neighbour('RoomB3','FrontRoomB3').
neighbour('LeftHallC','FrontRoomC1').
neighbour('FrontRoomC1','LeftHallC').
neighbour('RightHallB','RightHallC').
neighbour('RightHallC','RightHallB').
neighbour('FrontRoomB2','RoomB2').
neighbour('RoomB2','FrontRoomB2').
neighbour('FrontRoomB3','RightHallB').
neighbour('RightHallB','FrontRoomB3').
neighbour('RightHallC','RightHallD').
neighbour('RightHallD','RightHallC').
neighbour('RightHallA','RightHallB').
neighbour('RightHallB','RightHallA').
neighbour('FrontRoomA3','RightHallA').
neighbour('RightHallA','FrontRoomA3').
neighbour('FrontRoomA2','RoomA2').
neighbour('RoomA2','FrontRoomA2').
neighbour('LeftHallA','LeftHallB').
neighbour('LeftHallB','LeftHallA').
neighbour('FrontRoomC2','RoomC2').
neighbour('RoomC2','FrontRoomC2').
neighbour('RoomC3','FrontRoomC3').
neighbour('FrontRoomC3','RoomC3').
neighbour('FrontRoomA1','LeftHallA').
neighbour('LeftHallA','FrontRoomA1').

closestRoom(AllRooms,CurrentRoom,ClosestRoom) :-
	getClosestRoom(AllRooms,ClosestRoom,[CurrentRoom]).

getNeighbours([],[]).
getNeighbours([A|T],Neighbours) :-
	findall(N,neighbour(A,N),NList),
	getNeighbours(T,NewNeighbours),
	append(NewNeighbours,NList,Neighbours).

getClosestRoom(Al,Cl,Acc) :-
	getNeighbours(Acc,FoundList),
	flatten(FoundList,FlatList),
	append(Acc,FlatList,NewList),
	list_to_set(NewList,NewAcc),
	intersection(Al,NewAcc,NewFoundList),
	length(NewFoundList,Size),
	( Size > 0
		->nth0(0, NewFoundList, Cl)
		;
	(   length(NewAcc, NewLength), length(Acc, NewLength))
		->  false1
		;   getClosestRoom(Al,Cl,NewAcc)).

test(X) :-
	closestRoom(['RoomA1','RoomA2','RoomA3'],'RoomC2',X).
