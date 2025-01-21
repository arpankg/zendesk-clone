export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type TicketStatus = 'new' | 'open' | 'pending' | 'closed'
export type TicketPriority = 'low' | 'medium' | 'high'

export interface Database {
  public: {
    Tables: {
      tickets: {
        Row: {
          id: string
          title: string
          description: string
          status: TicketStatus
          priority: TicketPriority
          tags: string[]
          custom_fields: Json
          conversation_history: {
            messages: Array<{
              id: string
              content: string
              created_at: string | null
              created_by: string
              attachments: any[]
            }>
          }
          internal_notes: {
            notes: Array<{
              id: string
              content: string
              created_at: string | null
              created_by: string
            }>
          }
          feedback: {
            rating: number
            comment: string
            submitted_at: string | null
          }
          source_channel: string
          created_at: string | null
          updated_at: string | null
          created_by: string
          customer_email: string
          assigned_to: string[]
        }
        Insert: {
          id?: string
          title: string
          description: string
          status?: string
          priority?: string
          tags?: string[]
          custom_fields?: Json
          conversation_history?: {
            messages: Array<{
              id: string
              content: string
              created_at: string | null
              created_by: string
              attachments: any[]
            }>
          }
          internal_notes?: {
            notes: Array<{
              id: string
              content: string
              created_at: string | null
              created_by: string
            }>
          }
          feedback?: {
            rating: number
            comment: string
            submitted_at: string | null
          }
          source_channel?: string
          created_at?: string | null
          updated_at?: string | null
          created_by: string
          customer_email?: string
          assigned_to?: string[]
        }
        Update: {
          id?: string
          title?: string
          description?: string
          status?: string
          priority?: string
          tags?: string[]
          custom_fields?: Json
          conversation_history?: {
            messages: Array<{
              id: string
              content: string
              created_at: string | null
              created_by: string
              attachments: any[]
            }>
          }
          internal_notes?: {
            notes: Array<{
              id: string
              content: string
              created_at: string | null
              created_by: string
            }>
          }
          feedback?: {
            rating: number
            comment: string
            submitted_at: string | null
          }
          source_channel?: string
          created_at?: string | null
          updated_at?: string | null
          created_by?: string
          customer_email?: string
          assigned_to?: string[]
        }
      }
      customers: {
        Row: {
          id: string
          first_name: string
          last_name: string
          communication_channels: string[]
          preferred_language: string
          email: string
          feedback_history: {
            feedback: Array<{
              rating: number
              comment: string
              submitted_at: string | null
              ticket_id: string
            }>
          }
        }
        Insert: {
          id: string
          first_name: string
          last_name: string
          communication_channels?: string[]
          preferred_language?: string
          email: string
          feedback_history?: {
            feedback: Array<{
              rating: number
              comment: string
              submitted_at: string | null
              ticket_id: string
            }>
          }
        }
        Update: {
          id?: string
          first_name?: string
          last_name?: string
          communication_channels?: string[]
          preferred_language?: string
          email?: string
          feedback_history?: {
            feedback: Array<{
              rating: number
              comment: string
              submitted_at: string | null
              ticket_id: string
            }>
          }
        }
      }
    }
  }
}
