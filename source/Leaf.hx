class Leaf extends flixel.FlxBasic
{
 
    private var MIN_LEAF_SIZE:Int = 6;
 
    public var y:Int;
    public var x:Int;
    public var width:Int;
    public var height:Int; // the position and size of this Leaf
 
    public var leftChild:Leaf; // the Leaf's left child Leaf
    public var rightChild:Leaf; // the Leaf's right child Leaf
    public var room:flixel.util.FlxRect; // the room that is inside this Leaf
    public var halls:Array<flixel.util.FlxRect>; // hallways to connect this Leaf to other Leafs
 
    public function new(X:Int, Y:Int, Width:Int, Height:Int)
    {
        super();
        // initialize our leaf
        x = X;
        y = Y;
        width = Width;
        height = Height;
    }
 
    public function split():Bool
    {
        // begin splitting the leaf into two children
        if (leftChild != null || rightChild != null)
            return false; // we're already split! Abort!
 
        // determine direction of split
        // if the width is >25% larger than height, we split vertically
        // if the height is >25% larger than the width, we split horizontally
        // otherwise we split randomly
        var splitH:Bool = flixel.util.FlxRandom.float() > 0.5;
		
        if (width > height && height / width >= 0.01)
            splitH = false;
        else if (height > width && width / height >= 0.01)
            splitH = true;
 
        var max:Int = (splitH ? height : width) - MIN_LEAF_SIZE; // determine the maximum height or width
        if (max <= MIN_LEAF_SIZE)
            return false; // the area is too small to split any more...
 
        var split:Int = flixel.util.FlxRandom.intRanged(MIN_LEAF_SIZE,max);// determine where we're going to split
 
        // create our left and right children based on the direction of the split
        if (splitH)
        {
            leftChild = new Leaf(x, y, width, split);
            rightChild = new Leaf(x, y + split, width, height - split);
        }
        else
        {
            leftChild = new Leaf(x, y, split, height);
            rightChild = new Leaf(x + split, y, width - split, height);
        }
        return true; // split successful!
    }

    public function createRooms():Void
    {
        // this function generates all the rooms and hallways for this Leaf and all of its children.
        if (leftChild != null || rightChild != null)
        {
            // this leaf has been split, so go into the children leafs
            if (leftChild != null)
            {
                leftChild.createRooms();
            }
            if (rightChild != null)
            {
                rightChild.createRooms();
            }

            // if there are both left and right children in this Leaf, create a hallway between them
            if (leftChild != null && rightChild != null)
            {
                createHall(leftChild.getRoom(), rightChild.getRoom());
            }  
        }
        else
        {
            // this Leaf is the ready to make a room
            var roomSize:flixel.util.FlxPoint;
            var roomPos:flixel.util.FlxPoint;

            // the room can be between 3 x 3 tiles to the size of the leaf - 2.
            roomSize = new flixel.util.FlxPoint(flixel.util.FlxRandom.intRanged(3, width - 2), flixel.util.FlxRandom.intRanged(3, height - 2));
            //trace(roomSize);
            // place the room within the Leaf, but don't put it right 
            // against the side of the Leaf (that would merge rooms together)
            var maxX:Int = cast width - roomSize.x - 1 + 0.5;
            var maxY:Int = cast height - roomSize.y - 1 + 0.5;
            roomPos = new flixel.util.FlxPoint(flixel.util.FlxRandom.intRanged(1, maxX), flixel.util.FlxRandom.intRanged(1, maxY));
            room = new flixel.util.FlxRect(x + roomPos.x, y + roomPos.y, roomSize.x, roomSize.y);
        }
    } 

    public function getRoom():flixel.util.FlxRect
    {
        // iterate all the way through these leafs to find a room, if one exists.
        if (room != null)
            return room;
        else
        {
            var lRoom:flixel.util.FlxRect = null;
            var rRoom:flixel.util.FlxRect = null;
            if (leftChild != null)
            {
                lRoom = leftChild.getRoom();
            }
            if (rightChild != null)
            {
                rRoom = rightChild.getRoom();
            }
            if (lRoom == null && rRoom == null)
                return null;
            else if (rRoom == null)
                return lRoom;
            else if (lRoom == null)
                return rRoom;
            //else if (flixel.util.FlxRandom.chanceRoll(0.5)) //this is totally stupid, why do you write blogs 
            else if (flixel.util.FlxRandom.float() > 0.5)    
                return lRoom;
            else
                return rRoom;
        }
    } 

    public function createHall(l:flixel.util.FlxRect, r:flixel.util.FlxRect):Void
    {
        // now we connect these two rooms together with hallways.
        // this looks pretty complicated, but it's just trying to figure out which point is where and then either draw a straight line, or a pair of lines to make a right-angle to connect them.
        // you could do some extra logic to make your halls more bendy, or do some more advanced things if you wanted.
     
        halls = new Array<flixel.util.FlxRect>();
     
        var point1:flixel.util.FlxPoint = new flixel.util.FlxPoint(flixel.util.FlxRandom.floatRanged(l.left + 1, l.right - 2), flixel.util.FlxRandom.floatRanged(l.top + 1, l.bottom - 2));
        var point2:flixel.util.FlxPoint = new flixel.util.FlxPoint(flixel.util.FlxRandom.floatRanged(r.left + 1, r.right - 2), flixel.util.FlxRandom.floatRanged(r.top + 1, r.bottom - 2));
     
        var w:Float = point2.x - point1.x;
        var h:Float = point2.y - point1.y;
     
        if (w < 0)
        {
            if (h < 0)
            {
                //if (flixel.util.FlxRandom.float() > 0.5)
                {
                    halls.push(new flixel.util.FlxRect(point2.x, point1.y, Math.abs(w) + 1, 2));
                    halls.push(new flixel.util.FlxRect(point2.x, point2.y, 2, Math.abs(h) +1 ));
                }
              
            }
            else if (h > 0)
            {
               
                if (flixel.util.FlxRandom.float() > 0.5)
                {
                    halls.push(new flixel.util.FlxRect(point2.x, point1.y, Math.abs(w), 2));
                    halls.push(new flixel.util.FlxRect(point2.x, point1.y, 2, Math.abs(h)));
                }
                else
                {
                    halls.push(new flixel.util.FlxRect(point2.x, point2.y, Math.abs(w), 2));
                    halls.push(new flixel.util.FlxRect(point1.x, point1.y, 2, Math.abs(h)));
                }
            }
            else // if (h == 0)
            {
                halls.push(new flixel.util.FlxRect(point2.x, point2.y, Math.abs(w), 2));
            }
        }
        else if (w > 0)
        {
            if (h < 0)
            {
                if (flixel.util.FlxRandom.float() > 0.5)
                {
                    halls.push(new flixel.util.FlxRect(point1.x, point2.y, Math.abs(w), 2));
                    halls.push(new flixel.util.FlxRect(point1.x, point2.y, 2, Math.abs(h)));
                }
                else
                {
                    halls.push(new flixel.util.FlxRect(point1.x, point1.y, Math.abs(w), 2));
                    halls.push(new flixel.util.FlxRect(point2.x, point2.y, 2, Math.abs(h)));
                }
            }
            else if (h > 0)
            {
                if (flixel.util.FlxRandom.float() > 0.5)
                {
                    halls.push(new flixel.util.FlxRect(point1.x, point1.y, Math.abs(w), 2));
                    halls.push(new flixel.util.FlxRect(point2.x, point1.y, 2, Math.abs(h)));
                }
                else
                {
                    halls.push(new flixel.util.FlxRect(point1.x, point2.y, Math.abs(w), 2));
                    halls.push(new flixel.util.FlxRect(point1.x, point1.y, 2, Math.abs(h)));
                }
            }
            else // if (h == 0)
            {
                halls.push(new flixel.util.FlxRect(point1.x, point1.y, Math.abs(w), 2));
            }
        }
        else // if (w == 0)
        {
            if (h < 0)
            {
                halls.push(new flixel.util.FlxRect(point2.x, point2.y, 2, Math.abs(h)));
            }
            else if (h > 0)
            {
                halls.push(new flixel.util.FlxRect(point1.x, point1.y, 2, Math.abs(h)));
            }
        }
    }    
}