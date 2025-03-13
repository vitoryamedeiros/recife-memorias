
import React from 'react';
import { Link } from 'react-router-dom';
import { ThumbsUp, Eye, Calendar } from 'lucide-react';
import { Story, getLocationById } from '@/data';
import TagBadge from '@/components/ui/TagBadge';
import { formatDistanceToNow } from 'date-fns';
import { ptBR } from 'date-fns/locale';

interface StoryCardProps {
  story: Story;
}

const StoryCard: React.FC<StoryCardProps> = ({ story }) => {
  const location = getLocationById(story.locationId);
  
  return (
    <div className="bg-white rounded-lg shadow-md overflow-hidden transition-all hover:shadow-lg">
      {story.media && story.media.length > 0 && (
        <div className="relative h-48 overflow-hidden">
          <img 
            src={story.media[0]} 
            alt={story.title}
            className="w-full h-full object-cover transition-transform hover:scale-105"
          />
          <div className="absolute inset-0 bg-gradient-to-b from-transparent to-black/60"></div>
          <div className="absolute bottom-0 left-0 p-4 text-white">
            <h3 className="text-xl font-bold">{story.title}</h3>
          </div>
        </div>
      )}
      
      <div className="p-4">
        {(!story.media || story.media.length === 0) && (
          <h3 className="text-xl font-bold mb-2">{story.title}</h3>
        )}
        
        <Link to={`/location/${story.locationId}`} className="text-recife-primary hover:underline mb-2 block">
          {location?.name || 'Local Desconhecido'}
        </Link>
        
        <p className="text-sm text-recife-dark line-clamp-3 mb-3">
          {story.content}
        </p>
        
        <div className="flex flex-wrap gap-1 mb-4">
          {story.tags.slice(0, 3).map(tag => (
            <TagBadge key={tag}>{tag}</TagBadge>
          ))}
          {story.tags.length > 3 && (
            <TagBadge variant="outline">+{story.tags.length - 3}</TagBadge>
          )}
        </div>
        
        <div className="flex justify-between items-center text-sm text-recife-medium">
          <div className="flex space-x-4">
            <div className="flex items-center gap-1">
              <ThumbsUp size={16} />
              <span>{story.votes}</span>
            </div>
            <div className="flex items-center gap-1">
              <Eye size={16} />
              <span>{story.views}</span>
            </div>
          </div>
          
          <div className="flex items-center gap-1">
            <Calendar size={16} />
            <span>
              {formatDistanceToNow(story.createdAt, { 
                addSuffix: true,
                locale: ptBR 
              })}
            </span>
          </div>
        </div>
        
        <Link 
          to={`/story/${story.id}`}
          className="block text-center bg-recife-primary hover:bg-recife-primary-hover text-white py-2 rounded-md font-medium transition-colors mt-4"
        >
          Ler História
        </Link>
      </div>
    </div>
  );
};

export default StoryCard;
