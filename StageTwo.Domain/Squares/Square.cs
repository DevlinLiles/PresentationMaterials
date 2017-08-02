using System.Collections.Generic;
using System.Linq;

namespace StageTwo.Domain
{
    public abstract class Square
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

    public class NoOp : Square
    {
        public NoOp(string name) : base(name)
        {

        }
    }

    public class CardDraw : Square
    {
        private readonly Stack<Card> _cards;

        public CardDraw(string name, Stack<Card> cards) : base(name)
        {
            _cards = cards;
        }

        public override void Land(Player player)
        {
            var card = _cards.Pop();
            card.Execute(player);
        }
    }

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

    public class PropertyGroup
    {
        public string Name { get; }
        public IList<Property> Properties { get; } = new List<Property>();

        public PropertyGroup(string name)
        {
            Name = name;
        }

        public void AddProperty(Property property)
        {
            Properties.Add(property);
        }
    }
}