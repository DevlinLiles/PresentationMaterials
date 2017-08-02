namespace StageTwo.Domain
{
    public class RollResult
    {
        public RollResult(int dieOne, int dieTwo)
        {
            NumberRolled = dieOne + dieTwo;
            IsDoubles = dieOne == dieTwo;
        }
        public int NumberRolled { get; }
        public bool IsDoubles { get; }

    }
}