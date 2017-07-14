namespace StageOne.Domain
{
    public class Player
    {
        public Player(Token token, string name)
        {
            Token = token;
            Name = name;
            Money = 1500;
        }

        public string Name { get; set; }
        public Token Token { get; set; }
        public int Money { get; set; }
        public bool Bankrupt { get; set; }
        public int CurrentSquare { get; set; }


        public void TakeTurn(IDice dice, Square[] board)
        {
            var roll = dice.Roll();
            for (int index = 0; index < roll.NumberRolled; index++)
            {
                CurrentSquare = CurrentSquare + 1;
                if (board[CurrentSquare].Type == SquareType.Go)
                {
                    Money += 200;
                }
            }
            var square = board[CurrentSquare];
            switch (square.Type)
            {
                case SquareType.Chance:
                    {

                    }
                    break;
                case SquareType.CommunityChest:
                    {

                    }
                    break;
                case SquareType.Go:
                    {

                    }
                    break;
                case SquareType.FreeParking:
                    {

                    }
                    break;
                case SquareType.GoToJail:
                    {

                    }
                    break;
                case SquareType.Railroad:
                    {
                        if (square.Owner == null)
                        {
                            if (Money >= square.Price)
                            {
                                Money -= square.Price;
                                square.Owner = this;
                            }
                        }
                        else if (square.Owner != this)
                        {
                            var rent = square.Rent;
                            int owned =0;
                            if (board[5].Owner == square.Owner)
                            {
                                owned++;
                            }
                            if (board[15].Owner == square.Owner)
                            {
                                owned++;
                            }
                            if (board[25].Owner == square.Owner)
                            {
                                owned++;
                            }
                            if (board[35].Owner == square.Owner)
                            {
                                owned++;
                            }
                            for (int index = 1; index < owned; index++)
                            {
                                rent = rent * 2;
                            }

                            square.Owner.Money += rent;
                            Money -= rent;
                        }
                    }
                    break;
                case SquareType.RealEstate:
                    {
                        if (square.Owner == null)
                        {
                            if (Money >= square.Price)
                            {
                                Money -= square.Price;
                                square.Owner = this;
                            }
                        }
                        else if (square.Owner != this)
                        {
                            square.Owner.Money += square.Rent;
                            Money -= square.Rent;
                        }

                    }
                    break;
                case SquareType.Utility:
                    {
                        if (square.Owner == null)
                        {
                            if (Money >= square.Price)
                            {
                                Money -= square.Price;
                                square.Owner = this;
                            }
                        }
                        else if (square.Owner != this)
                        {
                            int owned = 0;
                            if (board[12].Owner == square.Owner)
                            {
                                owned++;
                            }
                            if (board[28].Owner == square.Owner)
                            {
                                owned++;
                            }
                            var rent = owned == 2 ? 10 : 4 * roll.NumberRolled;
                            square.Owner.Money += rent;
                            Money -= rent;
                        }
                    }
                    break;
            }
        }
    }
}