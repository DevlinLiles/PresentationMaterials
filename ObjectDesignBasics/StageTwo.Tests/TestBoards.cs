using System.Collections.Generic;
using System.Linq;
using StageTwo.Domain;

namespace StageTwo.Tests
{
    public class TestBoards
    {
        public static Square[] RealBoard()
        {
            var propertyGroups = new PropertyGroup[]
            {
                new PropertyGroup("Purple"),
                new PropertyGroup("Light-Green"),
                new PropertyGroup("Violet"),
                new PropertyGroup("Orange"),
                new PropertyGroup("Red"),
                new PropertyGroup("Yellow"),
                new PropertyGroup("Dark-Green"),
                new PropertyGroup("Dark-Blue"),
                new PropertyGroup("Utilities"),
                new PropertyGroup("Railroads"),
            };
            return new[]
            {
                new Go(),
                new RealEstate("Mediterranean Ave", propertyGroups[0], 60, 2),
                new CardDraw("Community Chest", new Stack<Card>()), 
                new RealEstate("Baltic Ave", 60, 4),
                new NoOp("Income Tax"), 
                new Railroad("Reading Railroad",propertyGroups.Last()), 
                new RealEstate("Oriental Ave", 100, 6),
                new CardDraw("Chance"), 
                new RealEstate("Vermont Ave", 100, 6),
                new RealEstate("Connecticut Ave", 120, 8),
                new NoOp("Just Visiting"), 
                new RealEstate("St. Charles Place", 140, 10),
                new Utility("Electric Company",propertyGroups[8], 150, 0), 
                new RealEstate("States Ave", 140, 10),
                new RealEstate("Virginia Ave", 160, 12),
                new Railroad("Pennsylvania Railroad", propertyGroups.Last()), 
                new RealEstate("St. James Place", 180, 14),
                new Square("Community Chest", 0, 0),
                new RealEstate("Tennessee Ave", 180, 14),
                new RealEstate("New York Ave", 200, 16),
                new Square("Free Parking", 0, 0),
                new RealEstate("Kentucky Ave", 220, 18),
                new Square("Chance", 0, 0),
                new RealEstate("Indiana Ave", 220, 18),
                new RealEstate("Illinois Ave", 240, 20),
                new Square("B & O Railroad", 200, 25),
                new RealEstate("Atlantic Ave", 260, 22),
                new RealEstate("Ventnor Ave", 260, 22),
                new Square("Water Works", 150, 0),
                new RealEstate("Marvin Gardens", 280, 22),
                new NoOp("Go To Jail"), 
                new RealEstate("Pacific Ave", 300, 26),
                new RealEstate("North Carolina Ave", 300, 26),
                new CardDraw("Community Chest",new Stack<Card>()), 
                new RealEstate("Pennsylvania Ave", 320, 28),
                new Railroad("Short Line",propertyGroups.Last()), 
                new CardDraw("Chance",new Stack<Card>()), 
                new RealEstate("Park Place", 350, 35),
                new NoOp("Luxury Tax", 0, 75), 
                new RealEstate("Boardwalk", 400, 50)
            };
        }
    }
}