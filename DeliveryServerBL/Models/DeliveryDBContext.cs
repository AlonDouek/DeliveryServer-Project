using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace DeliveryServerBL.Models
{
    public partial class DeliveryDBContext : DbContext
    {
        public DeliveryDBContext()
        {
        }

        public DeliveryDBContext(DbContextOptions<DeliveryDBContext> options)
            : base(options)
        {
        }

        public virtual DbSet<ItemCategory> ItemCategories { get; set; }
        public virtual DbSet<Menu> Menus { get; set; }
        public virtual DbSet<MenuItem> MenuItems { get; set; }
        public virtual DbSet<Order> Orders { get; set; }
        public virtual DbSet<OrderItem> OrderItems { get; set; }
        public virtual DbSet<OrderStatus> OrderStatuses { get; set; }
        public virtual DbSet<Restaurant> Restaurants { get; set; }
        public virtual DbSet<User> Users { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=localhost\\sqlexpress;Database=DeliveryDB;Trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "Hebrew_CI_AS");

            modelBuilder.Entity<ItemCategory>(entity =>
            {
                entity.HasKey(e => e.CategoryId)
                    .HasName("itemcategory_categoryid_primary");

                entity.ToTable("ItemCategory");

                entity.HasIndex(e => e.CategoryId, "itemcategory_categoryid_index");

                entity.Property(e => e.CategoryId).HasColumnName("CategoryID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<Menu>(entity =>
            {
                entity.ToTable("Menu");

                entity.HasIndex(e => new { e.RestaurantId, e.MenuId }, "menu_restaurantid_menuid_index");

                entity.Property(e => e.MenuId).HasColumnName("MenuID");

                entity.Property(e => e.RestaurantId).HasColumnName("RestaurantID");

                entity.HasOne(d => d.Restaurant)
                    .WithMany(p => p.Menus)
                    .HasForeignKey(d => d.RestaurantId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("menu_restaurantid_foreign");
            });

            modelBuilder.Entity<MenuItem>(entity =>
            {
                entity.ToTable("MenuItem");

                entity.HasIndex(e => e.MenuId, "menuitem_menuid_index");

                entity.HasIndex(e => e.MenuItemId, "menuitem_menuitemid_index");

                entity.Property(e => e.MenuItemId).HasColumnName("MenuItemID");

                entity.Property(e => e.CategoryId).HasColumnName("CategoryID");

                entity.Property(e => e.Description)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Image)
                    .IsRequired()
                    .HasMaxLength(255)
                    .HasDefaultValueSql("('default_Ip.jpg')");

                entity.Property(e => e.MenuId).HasColumnName("MenuID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Price).HasColumnType("decimal(8, 2)");

                entity.HasOne(d => d.Category)
                    .WithMany(p => p.MenuItems)
                    .HasForeignKey(d => d.CategoryId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("menuitem_categoryid_foreign");

                entity.HasOne(d => d.Menu)
                    .WithMany(p => p.MenuItems)
                    .HasForeignKey(d => d.MenuId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("menuitem_menuid_foreign");
            });

            modelBuilder.Entity<Order>(entity =>
            {
                entity.ToTable("Order");

                entity.HasIndex(e => e.OrderId, "order_orderid_index");

                entity.HasIndex(e => e.StatusId, "order_statusid_index");

                entity.HasIndex(e => e.UserId, "order_userid_index");

                entity.Property(e => e.OrderId).HasColumnName("OrderID");

                entity.Property(e => e.Note)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Price).HasColumnType("decimal(8, 2)");

                entity.Property(e => e.StatusId).HasColumnName("StatusID");

                entity.Property(e => e.UserId).HasColumnName("UserID");

                entity.HasOne(d => d.Status)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.StatusId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("order_statusid_foreign");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.UserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("order_userid_foreign");
            });

            modelBuilder.Entity<OrderItem>(entity =>
            {
                entity.HasKey(e => e.ItemId)
                    .HasName("orderitem_itemid_primary");

                entity.ToTable("OrderItem");

                entity.HasIndex(e => e.ItemId, "orderitem_itemid_index");

                entity.HasIndex(e => e.MenuItemId, "orderitem_menuitemid_index");

                entity.HasIndex(e => e.OrderId, "orderitem_orderid_index");

                entity.Property(e => e.ItemId).HasColumnName("ItemID");

                entity.Property(e => e.MenuItemId).HasColumnName("MenuItemID");

                entity.Property(e => e.OrderId).HasColumnName("OrderID");

                entity.HasOne(d => d.MenuItem)
                    .WithMany(p => p.OrderItems)
                    .HasForeignKey(d => d.MenuItemId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("orderitem_menuitemid_foreign");
            });

            modelBuilder.Entity<OrderStatus>(entity =>
            {
                entity.HasKey(e => e.StatusId)
                    .HasName("orderstatus_statusid_primary");

                entity.ToTable("OrderStatus");

                entity.HasIndex(e => e.StatusId, "orderstatus_statusid_index");

                entity.Property(e => e.StatusId).HasColumnName("StatusID");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<Restaurant>(entity =>
            {
                entity.ToTable("Restaurant");

                entity.HasIndex(e => e.Name, "restaurant_name_unique")
                    .IsUnique();

                entity.HasIndex(e => e.RestaurantId, "restaurant_restaurantid_index");

                entity.Property(e => e.RestaurantId).HasColumnName("RestaurantID");

                entity.Property(e => e.Description)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Image)
                    .IsRequired()
                    .HasMaxLength(255)
                    .HasDefaultValueSql("('default_Rp.jpg')");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.ResAddress)
                    .IsRequired()
                    .HasMaxLength(255);
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.ToTable("User");

                entity.HasIndex(e => e.Email, "user_email_unique")
                    .IsUnique();

                entity.HasIndex(e => e.PhoneNumber, "user_phonenumber_unique")
                    .IsUnique();

                entity.HasIndex(e => e.UserId, "user_userid_index");

                entity.Property(e => e.UserId).HasColumnName("UserID");

                entity.Property(e => e.Address)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.CreditCard)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Password)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.PhoneNumber)
                    .IsRequired()
                    .HasMaxLength(255);

                entity.Property(e => e.Username)
                    .IsRequired()
                    .HasMaxLength(255);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
