namespace StageOne.Domain
{
    public class Square
    {
        public Square(SquareType squareType, string name, int price, int rent)
        {
            Name = name;
            Price = price;
            Rent = rent;
            Type = squareType;
        }

        public string Name { get; set; }
        public int Rent { get; set; }
        public int Price { get; set; }
        public SquareType Type { get; set; }
        public Player Owner { get; set; }
    }
}