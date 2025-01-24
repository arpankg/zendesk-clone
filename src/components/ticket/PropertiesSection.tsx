import { type TicketStatus, type TicketPriority } from '@/config/types'
import { useState, useRef, useEffect } from 'react'

interface PropertiesSectionProps {
  sourceChannel: string
  tags: string[]
  isExpanded?: boolean
  onRemoveTag: (tag: string) => Promise<void>
}

export function PropertiesSection({
  sourceChannel,
  tags,
  isExpanded = true,
  onRemoveTag
}: PropertiesSectionProps) {
  const [isAddingTag, setIsAddingTag] = useState(false)
  const [newTag, setNewTag] = useState('')
  const inputRef = useRef<HTMLDivElement>(null)

  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (inputRef.current && !inputRef.current.contains(event.target as Node)) {
        setIsAddingTag(false)
        setNewTag('')
      }
    }

    document.addEventListener('mousedown', handleClickOutside)
    return () => document.removeEventListener('mousedown', handleClickOutside)
  }, [])

  return (
    <div className="border-b border-gray-200 pb-4">
      <div className="flex items-center justify-between mb-2">
        <h3 className="text-sm font-medium text-gray-900">Properties</h3>
        <button className="p-1 text-gray-400 hover:text-gray-600">
          <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
          </svg>
        </button>
      </div>

      {isExpanded && (
        <div className="space-y-4">
          {/* Tags Section */}
          <div>
            <div className="flex items-center justify-between">
              <div className="text-sm text-gray-500">Tags</div>
              <button 
                className="text-sm text-blue-600 hover:text-blue-700"
                onClick={() => setIsAddingTag(true)}
              >
                Add
              </button>
            </div>
            <div className="mt-2 flex flex-wrap gap-2">
              {tags.map((tag) => (
                <span
                  key={tag}
                  className="inline-flex items-center gap-1 rounded-full bg-gray-50 px-2 py-1 text-xs font-medium text-gray-600"
                >
                  {tag}
                  <button
                    type="button"
                    className="text-gray-400 hover:text-gray-600"
                    onClick={() => onRemoveTag(tag)}
                  >
                    <svg className="h-3 w-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                    </svg>
                  </button>
                </span>
              ))}
              {tags.length === 0 && (
                <span className="text-sm text-gray-500">No tags</span>
              )}
            </div>
            {isAddingTag && (
              <div ref={inputRef} className="mt-2 flex items-center gap-2">
                <input
                  type="text"
                  value={newTag}
                  onChange={(e) => setNewTag(e.target.value)}
                  placeholder="Enter tag"
                  className="flex-1 rounded-md border-0 py-1.5 px-2 text-sm text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-blue-600"
                />
                <button
                  type="button"
                  className="rounded-md bg-blue-600 px-2.5 py-1.5 text-sm font-semibold text-white shadow-sm hover:bg-blue-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600"
                >
                  Submit
                </button>
              </div>
            )}
          </div>

          {/* Source Section */}
          <div>
            <div className="text-sm text-gray-500">Source</div>
            <div className="mt-1 text-sm text-gray-900">{sourceChannel}</div>
          </div>
        </div>
      )}
    </div>
  )
}
