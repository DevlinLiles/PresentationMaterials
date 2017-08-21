namespace StageTwo.Domain
{
    public abstract class Property : Square
    {
        public PropertyGroup PropertyGroup { get; }
        public int PurchasePrice { get; }
        public int RentPrice { get; }

        public Player Owner { get; protected set; }

        protected Property(string name, PropertyGroup propertyGroup, int purchasePrice, int rent) : base(name)
        {
            PropertyGroup = propertyGroup;
            PurchasePrice = purchasePrice;
            RentPrice = rent;
        }

        public abstract void PayRent(Player player);
        public override void Land(Player player)
        {
            if (Owner == null)
            {
                if (player.Money >= PurchasePrice)
                {
                    Buy(player);
                }
            }
            else
            {
                if (Owner != player)
                {
                    PayRent(player);
                }
            }
        }

        public void Buy(Player player)
        {
            player.Money -= PurchasePrice;
            Owner = player;
        }
    }
}