import { useState } from 'react'

interface Note {
  id: string
  content: string
  created_at: string | null
  created_by: string
}

interface NotesSectionProps {
  notes: Note[]
  isExpanded?: boolean
  onAddNote?: (content: string) => Promise<void>
}

export function NotesSection({ notes, isExpanded = true, onAddNote }: NotesSectionProps) {
  const [isAddingNote, setIsAddingNote] = useState(false)
  const [noteContent, setNoteContent] = useState('')

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!noteContent.trim() || !onAddNote) return

    await onAddNote(noteContent.trim())
    setNoteContent('')
    setIsAddingNote(false)
  }

  const formatDate = (date: string | null) => {
    if (!date) return ''
    return new Date(date).toLocaleString('en-US', {
      month: 'short',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
      hour12: true
    })
  }

  return (
    <div className="pb-4">
      <div className="flex items-center justify-between mb-2">
        <h3 className="text-sm font-medium text-gray-900">Internal Notes</h3>
        <div className="flex items-center space-x-2">
          <button 
            className="text-sm text-blue-600 hover:text-blue-700"
            onClick={() => setIsAddingNote(true)}
          >
            Add note
          </button>
          <button className="p-1 text-gray-400 hover:text-gray-600">
            <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
            </svg>
          </button>
        </div>
      </div>

      {isExpanded && (
        <div className="space-y-4">
          {isAddingNote && (
            <form onSubmit={handleSubmit} className="mb-4">
              <textarea
                value={noteContent}
                onChange={(e) => setNoteContent(e.target.value)}
                className="w-full p-2 border rounded resize-none focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                placeholder="Add a note..."
                rows={3}
              />
              <div className="mt-2 flex justify-end space-x-2">
                <button
                  type="button"
                  onClick={() => {
                    setIsAddingNote(false)
                    setNoteContent('')
                  }}
                  className="px-3 py-1 text-sm text-gray-600 hover:text-gray-800"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  disabled={!noteContent.trim()}
                  className="px-3 py-1 text-sm bg-blue-600 text-white rounded hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  Add
                </button>
              </div>
            </form>
          )}
          
          {[...notes].sort((a, b) => 
            new Date(b.created_at || 0).getTime() - new Date(a.created_at || 0).getTime()
          ).map((note) => (
            <div key={note.id} className="bg-gray-50 rounded-lg p-3">
              <div className="text-sm text-gray-900">{note.content}</div>
              <div className="mt-2 text-xs text-gray-500">
                {formatDate(note.created_at)}
              </div>
            </div>
          ))}
          {notes.length === 0 && !isAddingNote && (
            <div className="text-sm text-gray-500 text-center py-4">
              No internal notes yet
            </div>
          )}
        </div>
      )}
    </div>
  )
}
