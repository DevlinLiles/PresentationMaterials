namespace StageTwo.Domain
{
    public class Player
    {
        public Player(Token token, string name, Square startSquare)
        {
            Token = token;
            Name = name;
            Money = 1500;
            CurrentSquare = startSquare;
        }

        public string Name { get; set; }
        public Token Token { get; set; }
        public int Money { get; set; }
        public bool Bankrupt { get; set; }
        public Square CurrentSquare { get; set; }
        public RollResult LastRoll { get; set; }


        public void TakeTurn(IDice dice)
        {
            var roll = dice.Roll();
            for (int index = 0; index < roll.NumberRolled; index++)
            {
                CurrentSquare = CurrentSquare.Next;
                CurrentSquare.Pass(this);
            }
            CurrentSquare.Land(this);
        }

        public void ChangeMoney(int change)
        {
            Money += change;
        }
    }
}