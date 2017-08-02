using System;
using System.Linq;
using FluentAssertions;
using NSubstitute;
using NUnit.Framework;
using StageTwo.Domain;

namespace StageTwo.Tests
{
    public class GameTests
    {
        [Test]
        public void CanSetupGameWithBoard()
        {
            // Arrange
            IDice dice = Substitute.For<IDice>();

            // Act
            var game = new Game(dice);

            // Assert
            game.Board.First().Type.Should().BeOfType<Go>();
            game.Board.Where(x => x.Type == SquareType.Chance).Should().HaveCount(3);
            game.Board.Where(x => x.Type == SquareType.CommunityChest).Should().HaveCount(3);
            game.Board.Where(x => x.Type == SquareType.Go).Should().HaveCount(1);
            game.Board.Where(x => x.Type == SquareType.FreeParking).Should().HaveCount(1);
            game.Board.Where(x => x.Type == SquareType.GoToJail).Should().HaveCount(1);
            game.Board.Where(x => x.Type == SquareType.JustVisiting).Should().HaveCount(1);
            game.Board.Where(x => x.Type == SquareType.LuxuryTax).Should().HaveCount(1);
            game.Board.Where(x => x.Type == SquareType.IncomeTax).Should().HaveCount(1);
            game.Board.Where(x => x.Type == SquareType.RealEstate).Should().HaveCount(22);
            game.Board.Where(x => x.Type == SquareType.Railroad).Should().HaveCount(4);
            game.Board.Where(x => x.Type == SquareType.Utility).Should().HaveCount(2);
        }

        [Test]
        public void ShouldRequireDice()
        {
            // Arrange
            
            // Act
            Action action = () => new Game(null);
            // Assert
            action.ShouldThrow<ArgumentNullException>().Which.Message.Contains("dice");
        }
    }
}
