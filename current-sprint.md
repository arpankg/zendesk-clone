1. **Message List Structure**
   - Create a scrollable container for conversation history
   - Implement message bubbles with alternating background colors for customer/agent
   - Add avatar initials with color-coding based on user type
   - Display timestamps using your existing dateUtils with relative formatting

2. **Message Metadata Display**
   - Show user name above each message
   - Add "Via [Channel]" indicator below messages
   - Include invisible hover timestamps with exact date/time

3. **Rich Text Composition Box**
   - Create a fixed-bottom message input area
   - Implement a toolbar with basic formatting (bold, italic, lists)
   - Add attachment button with file type restrictions

6. **Real-Time Sync**
   - Subscribe to ticket changes using Supabase realtime
   - Add visual indicators for new incoming messages
   - Implement scroll-to-bottom behavior for new messages

7. 9. **System Message Types**
   - Create templates for status change notifications
   - Add internal note visibility toggles
   - Implement "Private" vs "Public" message indicators
   - Add automated SLA breach warnings

## Implementation Details

### Data Storage
- Messages will be stored in the existing `ticket_history` JSONB field in the tickets table
- Real-time messaging will be implemented using Supabase's realtime subscriptions

### UI Components
- Message container height will be dynamic based on viewport
- Rich text editor: Will use the simplest available library
- File attachments: No specific type or size restrictions

### Message Types
- Only two types of messages will be implemented:
  1. Customer messages
  2. Agent messages
