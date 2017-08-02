using FluentAssertions;
using NSubstitute;
using NUnit.Framework;
using StageTwo.Domain;

namespace StageTwo.Tests
{
    [TestFixture]
    public class PlayerTests
    {
        [Test]
        public void ShouldMoveAroundTheBoard()
        {
            // Arrange
            Square[] realBoard = TestBoards.RealBoard();
            var player = new Player(Token.Automobile, "Test");
            var dice = Substitute.For<IDice>();
            dice.Roll().Returns(new RollResult(1, 2));
            // Act
            player.TakeTurn(dice, realBoard);

            // Assert
            player.CurrentSquare.Should().Be(3);
        }

        [Test]
        public void ShouldBeAbleToBuyUnownedRealestate()
        {
            // Arrange
            Square[] realBoard = TestBoards.RealBoard();
            var player = new Player(Token.Automobile, "Test");
            var dice = Substitute.For<IDice>();
            dice.Roll().Returns(new RollResult(1, 2));
            // Act
            player.TakeTurn(dice, realBoard);

            // Assert
            player.Money.Should().Be(1440);
            realBoard[player.CurrentSquare].Owner.Should().Be(player);
        }

        [Test]
        public void ShouldPayRentOnOwnedRealEstate()
        {
            // Arrange
            Square[] realBoard = TestBoards.RealBoard();
            var landlord = new Player(Token.Battleship, "Landlord");
            realBoard[3].Owner = landlord;
            var player = new Player(Token.Automobile, "Test");
            var dice = Substitute.For<IDice>();
            dice.Roll().Returns(new RollResult(1, 2));

            // Act
            player.TakeTurn(dice, realBoard);

            // Assert
            player.Money.Should().Be(1496);
            landlord.Money.Should().Be(1504);
            realBoard[player.CurrentSquare].Owner.Should().Be(landlord);
        }

        [Test]
        public void ShouldBeAbleToBuyUnownedRailroad()
        {
            // Arrange
            Square[] realBoard = TestBoards.RealBoard();
            var player = new Player(Token.Automobile, "Test");
            var dice = Substitute.For<IDice>();
            dice.Roll().Returns(new RollResult(3, 2));
            // Act
            player.TakeTurn(dice, realBoard);

            // Assert
            player.Money.Should().Be(1300);
            realBoard[player.CurrentSquare].Owner.Should().Be(player);
        }

        [Test]
        public void ShouldPayRentOnOwnedRailroad()
        {
            // Arrange
            Square[] realBoard = TestBoards.RealBoard();
            var landlord = new Player(Token.Battleship, "Landlord");
            realBoard[5].Owner = landlord;
            var player = new Player(Token.Automobile, "Test");
            var dice = Substitute.For<IDice>();
            dice.Roll().Returns(new RollResult(3, 2));

            // Act
            player.TakeTurn(dice, realBoard);

            // Assert
            player.Money.Should().Be(1475);
            landlord.Money.Should().Be(1525);
            realBoard[player.CurrentSquare].Owner.Should().Be(landlord);
        }

        [Test]
        public void ShouldPayRentOnTwoOwnedRailroad()
        {
            // Arrange
            Square[] realBoard = TestBoards.RealBoard();
            var landlord = new Player(Token.Battleship, "Landlord");
            realBoard[5].Owner = landlord;
            realBoard[15].Owner = landlord;
            var player = new Player(Token.Automobile, "Test");
            var dice = Substitute.For<IDice>();
            dice.Roll().Returns(new RollResult(3, 2));

            // Act
            player.TakeTurn(dice, realBoard);

            // Assert
            player.Money.Should().Be(1450);
            landlord.Money.Should().Be(1550);
            realBoard[player.CurrentSquare].Owner.Should().Be(landlord);
        }

        [Test]
        public void ShouldPayRentOnThreeOwnedRailroad()
        {
            // Arrange
            Square[] realBoard = TestBoards.RealBoard();
            var landlord = new Player(Token.Battleship, "Landlord");
            realBoard[5].Owner = landlord;
            realBoard[15].Owner = landlord;
            realBoard[25].Owner = landlord;
            var player = new Player(Token.Automobile, "Test");
            var dice = Substitute.For<IDice>();
            dice.Roll().Returns(new RollResult(3, 2));

            // Act
            player.TakeTurn(dice, realBoard);

            // Assert
            player.Money.Should().Be(1400);
            landlord.Money.Should().Be(1600);
            realBoard[player.CurrentSquare].Owner.Should().Be(landlord);
        }

        [Test]
        public void ShouldPayRentOnFourOwnedRailroad()
        {
            // Arrange
            Square[] realBoard = TestBoards.RealBoard();
            var landlord = new Player(Token.Battleship, "Landlord");
            realBoard[5].Owner = landlord;
            realBoard[15].Owner = landlord;
            realBoard[25].Owner = landlord;
            realBoard[35].Owner = landlord;
            var player = new Player(Token.Automobile, "Test");
            var dice = Substitute.For<IDice>();
            dice.Roll().Returns(new RollResult(3, 2));

            // Act
            player.TakeTurn(dice, realBoard);

            // Assert
            player.Money.Should().Be(1300);
            landlord.Money.Should().Be(1700);
            realBoard[player.CurrentSquare].Owner.Should().Be(landlord);
        }

        [Test]
        public void ShouldNotPayRentWhenYouOwnTheLocation()
        {
            // Arrange
            Square[] realBoard = TestBoards.RealBoard();
            var player = new Player(Token.Automobile, "Test");
            realBoard[3].Owner = player;
            var dice = Substitute.For<IDice>();
            dice.Roll().Returns(new RollResult(1, 2));

            // Act
            player.TakeTurn(dice, realBoard);

            // Assert
            player.Money.Should().Be(1500);
            realBoard[player.CurrentSquare].Owner.Should().Be(player);
        }
    }
}