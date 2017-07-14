using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StageOne.Domain
{
    public class Game
    {
        private IDice _dice;

        public Game(IDice dice)
        {
            _dice = dice ?? throw new ArgumentNullException("Cannot play the game without dice.");
            Board = SetupBoard();
        }

        private static Square[] SetupBoard()
        {
            return new []
            {
                new Square(SquareType.Go, "Go", 0, 0),
                new Square(SquareType.RealEstate, "Mediterranean Ave", 60, 2),
                new Square(SquareType.CommunityChest, "Community Chest", 0, 0),
                new Square(SquareType.RealEstate, "Baltic Ave", 60, 4),
                new Square(SquareType.IncomeTax, "Income Tax", 0, 0),
                new Square(SquareType.Railroad, "Reading Railroad", 200, 0),
                new Square(SquareType.RealEstate, "Oriental Ave", 100, 6),
                new Square(SquareType.Chance, "Chance", 0, 0),
                new Square(SquareType.RealEstate, "Vermont Ave", 100, 6),
                new Square(SquareType.RealEstate, "Connecticut Ave", 120, 8),
                new Square(SquareType.JustVisiting, "Just Visiting", 0, 0),
                new Square(SquareType.RealEstate, "St. Charles Place", 140, 10),
                new Square(SquareType.Utility, "Electric Company", 150, 0),
                new Square(SquareType.RealEstate, "States Ave", 140, 10),
                new Square(SquareType.RealEstate, "Virginia Ave", 160, 12),
                new Square(SquareType.Railroad, "Pennsylvania Railroad", 200, 0),
                new Square(SquareType.RealEstate, "St. James Place", 180, 14),
                new Square(SquareType.CommunityChest, "Community Chest", 0, 0),
                new Square(SquareType.RealEstate, "Tennessee Ave", 180, 14),
                new Square(SquareType.RealEstate, "New York Ave", 200, 16),
                new Square(SquareType.FreeParking, "Free Parking", 0, 0),
                new Square(SquareType.RealEstate, "Kentucky Ave", 220, 18),
                new Square(SquareType.Chance, "Chance", 0, 0),
                new Square(SquareType.RealEstate, "Indiana Ave", 220, 18),
                new Square(SquareType.RealEstate, "Illinois Ave", 240, 20),
                new Square(SquareType.Railroad, "B & O Railroad", 200, 0),
                new Square(SquareType.RealEstate, "Atlantic Ave", 260, 22),
                new Square(SquareType.RealEstate, "Ventnor Ave", 260, 22),
                new Square(SquareType.Utility, "Water Works", 150, 0),
                new Square(SquareType.RealEstate, "Marvin Gardens", 280, 22),
                new Square(SquareType.GoToJail, "Go To Jail", 0, 0),
                new Square(SquareType.RealEstate, "Pacific Ave", 300, 26),
                new Square(SquareType.RealEstate, "North Carolina Ave", 300, 26),
                new Square(SquareType.CommunityChest, "Community Chest", 0, 0),
                new Square(SquareType.RealEstate, "Pennsylvania Ave", 320, 28),
                new Square(SquareType.Railroad, "Short Line", 200, 0),
                new Square(SquareType.Chance, "Chance", 0, 0),
                new Square(SquareType.RealEstate, "Park Place", 350, 35),
                new Square(SquareType.LuxuryTax, "Luxury Tax", 0, 75),
                new Square(SquareType.RealEstate, "Boardwalk", 400, 50)
            };
        }

        public List<Player> Players { get; set; }
        public Square[] Board { get; set; }

        public void AddPlayer(Token token, string name = null)
        {
            Players.Add(new Player(token, name ?? $"Player{Players.Count}"));
        }

        public void Play()
        {
            while (Players.Count(x => !x.Bankrupt) > 1)
            {
                foreach (var player in Players)
                {
                    player.TakeTurn(_dice, Board);
                }
            }
        }
    }
}
