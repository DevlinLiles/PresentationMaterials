using System.Collections.Generic;

namespace StageTwo.Domain
{
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