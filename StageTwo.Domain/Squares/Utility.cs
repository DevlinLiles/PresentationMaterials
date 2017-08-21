using System.Linq;

namespace StageTwo.Domain
{
    public class Utility : Property
    {
        public Utility(string name, PropertyGroup propertyGroup, int purchasePrice, int rent) : base(name, propertyGroup, purchasePrice, rent)
        {
        }

        public override void PayRent(Player player)
        {
            int rent = 0;
            if (PropertyGroup.Properties.All(x => x.Owner == Owner))
            {
                rent = 10 * player.LastRoll.NumberRolled;

            }
            else
            {
                rent = 4 * player.LastRoll.NumberRolled;
            }
            Owner.Money += rent;
            player.Money -= rent;
        }
    }
}