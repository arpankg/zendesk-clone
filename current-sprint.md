# Current Feature Work

## Pages to Create
We need to create the following React pages:

1. `WorkerDashboard.tsx` - Dashboard for support workers
2. `CustomerDashboard.tsx` - Dashboard for customers
3. `Support.tsx` - Page for new customers to create tickets
4. `Login.tsx` - Login page
5. `Signup.tsx` - Sign up page

## Dashboard Components

### Ticket List Component
- `TicketList.tsx` - List view for tickets
    - Priority Sorting
    - View Status
    - View Tags
    - Last Updated
    - Pagination

### Header Component
- `DashboardHeader.tsx` - Header Component for Dashboard
    - Profile View Button - button to change user's profile settings or log out
    - Search Bar - component to search through all of a user's tickets


Sample User
User UID - 5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58
User Email - arpan@gmail.com

## Implementation Steps

### 1. Support Page Ticket Creation
1. Modify `src/pages/Support.tsx`:
   - Add form submission handler with:
     - Hardcoded user ID: "5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58" as created_by
     - Form fields:
       - Email (required)
       - Title (required)
       - Description (required, plaintext)
     - Default values:
       - status: "new"
       - source_channel: "web"
       - priority: "normal"
   - Add form validation
   - Implement Supabase ticket creation
   - Add success/error notifications

### 2. Sign Up Implementation
1. Create `src/pages/SignUp.tsx`:
   - Form fields based on customers table:
     - First Name (required)
     - Last Name (required)
     - Email (required, unique)
     - Password (required)
   - Add form validation
   - Implement Supabase auth.signUp
   - Create customer record in customers table
   - Add success/error notifications
