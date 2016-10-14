class Category < ActiveRecord::Base
  # Define the varidations needed for the category model
  validates :name, presence: true, length: { minimum: 4 }

  # Associations needed to implement the parent/child relationships
  has_many :children, class_name: 'Category', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Category', foreign_key: 'parent_id'

  # Associations needed to implement the product_categories join relationships
  has_many :product_categories
  has_many :products, through: :product_categories

  # Associations needed to implement the stockproduct_categories join relationships
  has_many :stockproduct_categories
  has_many :stockproducts, through: :stockproduct_categories

  # Recursive function that will retrieve a count of products within a given category and all its subcategories
  def get_total_product_count
    # Get the count of products that belong to the current category
    count = self.products.count()
    # Loop through each subcategory and recursively call the same function and add the count from its result
    self.children.each { |subcategory| count += subcategory.get_total_product_count }
    # Return the result
    return count
  end

  # Will retrieve the count of sub categories that have a given category as their parent.
  # This function is not recursive and will only go one level down.
  def get_immediate_subcategory_count
    return self.children.count()
  end

  # Recursive function that will retrieve all of the product objects within a given category and all its subcategories
  def get_all_products(level = 0, result = [])
    # Add the current level and products to the result array if any exist
    if(!self.products.empty?)
      # We have products, we will iterate through all of them and add them to our result array
      self.products.each do |p|
        result.push([level, p])
      end
    end

    # Check to see if we have any subcategories
    if(!self.children.empty?)
      # We have subcategories, we will iterate though all of them and recursively call this function
      self.children.each do |child|
        child.get_all_products(level+1, result)
      end
    end

    # End recursion if our level is 0 and return the result
    if(level == 0)
      return result
    end
  end

  # Recursively retrieves the list of parent categories given a subcategory ID
  def get_parent_categories(result = [])
    if(!self.parent.nil?)
      # Add the parent node to the results array
      result.push(self.parent)
      # Recursively call the function with the current object
      self.parent.get_parent_categories(result)
    end

    # End recursion and return result
    return result
  end

  # Recursive function that will retrieve all categories and their structure
  def get_subcategories(level = 0, result = [])
    # Add the current level and category to the result array
    result.push([level, self])

    # Check to see if we have any subcategories
    if(!self.children.empty?)
      # We have children, we will iterate through all of them and recursively call this function
      self.children.each do |child|
        child.get_subcategories(level+1, result)
      end
    end

    # End recursion if our level is 0 and return the result
    if(level == 0)
      return result
    end
  end

  # Retrieves all of the descendents of a category
  def descendents
    self_and_descendents - [self]
  end

  # Retrieves all of the descendents of a caterory and includes the current caregory
  def self_and_descendents
    self.class.tree_for(self)
  end

  # Retrieves the category tree of a given category. It will traverse the entire tree recursively
  # This uses Postgre SQL to execute the recursive query
  def self.tree_for(instance)
    where("#{table_name}.id IN (#{tree_sql_for(instance)})").order("#{table_name}.id").pluck(:id)
  end

  # Defines the Postgre SQL recursive query that will return the tree of subcategories given a parent category
  def self.tree_sql_for(instance)
    tree_sql =  <<-SQL
      WITH RECURSIVE search_tree(id, path) AS (
          SELECT id, ARRAY[id]
          FROM #{table_name}
          WHERE id = #{instance.id}
        UNION ALL
          SELECT #{table_name}.id, path || #{table_name}.id
          FROM search_tree
          JOIN #{table_name} ON #{table_name}.parent_id = search_tree.id
          WHERE NOT #{table_name}.id = ANY(path)
      )
      SELECT id FROM search_tree ORDER BY path
    SQL
  end

end
