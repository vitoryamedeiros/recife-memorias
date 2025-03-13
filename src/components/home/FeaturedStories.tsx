
import React from 'react';
import { Link } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { stories } from '@/data';
import StoryCard from '@/components/stories/StoryCard';

const FeaturedStories = () => {
  // Get top 3 stories by votes
  const topStories = [...stories]
    .sort((a, b) => b.votes - a.votes)
    .slice(0, 3);
  
  return (
    <section className="py-16">
      <div className="container mx-auto px-4">
        <div className="text-center mb-12">
          <h2 className="text-3xl font-bold mb-4">Histórias em Destaque</h2>
          <p className="text-recife-medium text-lg max-w-2xl mx-auto">
            Descubra as histórias mais populares compartilhadas pelos estudantes
          </p>
        </div>
        
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {topStories.map(story => (
            <StoryCard key={story.id} story={story} />
          ))}
        </div>
        
        <div className="text-center mt-10">
          <Link to="/ranking">
            <Button variant="outline" className="text-recife-primary border-recife-primary hover:bg-recife-primary hover:text-white">
              Ver ranking completo
            </Button>
          </Link>
        </div>
      </div>
    </section>
  );
};

export default FeaturedStories;
