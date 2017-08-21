using System.Collections.Generic;

namespace StageTwo.Domain
{
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
}