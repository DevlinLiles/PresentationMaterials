namespace StageTwo.Domain
{
    public class Railroad : Property
    {
        private readonly PropertyGroup _railroadGroup;

        public Railroad(string name, PropertyGroup railroadGroup) : base(name, railroadGroup, 200, 25)
        {
        }

        public override void PayRent(Player player)
        {
            var rent = RentPrice;
            foreach (var property in _railroadGroup.Properties)
            {
                if (property.Owner == Owner)
                {
                    rent = rent * 2;
                }
            }
            Owner.Money += rent;
            player.Money -= rent;
        }
    }
}