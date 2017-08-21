namespace StageTwo.Domain
{
    public class Go : Square
    {
        public Go() : base("Go")
        {

        }

        public override void Pass(Player player)
        {
            player.Money += 200;
        }
    }
}