namespace StageTwo.Domain
{
    public class RealEstate : Property
    {
        public RealEstate(string name, PropertyGroup propertyGroup, int purchasePrice, int rent) : base(name, propertyGroup, purchasePrice, rent)
        {
        }

        public override void PayRent(Player player)
        {
            Owner.ChangeMoney(RentPrice);
            player.ChangeMoney(-RentPrice);
        }
    }
}