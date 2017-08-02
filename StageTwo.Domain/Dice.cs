using System;

namespace StageTwo.Domain
{
    public class Dice : IDice
    {
        private static readonly Random Random = new Random();

        public RollResult Roll()
        {
            return new RollResult(Random.Next(1, 7), Random.Next(1, 7));
        }
    }
}