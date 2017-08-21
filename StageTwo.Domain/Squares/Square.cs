namespace StageTwo.Domain
{
    public class Square
    {
        protected Square(string name)
        {
            Name = name;
        }

        public string Name { get; set; }

        public Square Next { get; }
        public Square Previous { get; }

        public virtual void Pass(Player player)
        {

        }

        public virtual void Land(Player player)
        {

        }
    }
}