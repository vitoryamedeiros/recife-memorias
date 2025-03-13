
import React from 'react';
import { Link } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { locations } from '@/data';
import LocationCard from '@/components/locations/LocationCard';

const FeaturedLocations = () => {
  // Select the first 3 locations to showcase
  const featuredLocations = locations.slice(0, 3);
  
  return (
    <section className="py-16 bg-gray-50">
      <div className="container mx-auto px-4">
        <div className="text-center mb-12">
          <h2 className="text-3xl font-bold mb-4">Locais em Destaque</h2>
          <p className="text-recife-medium text-lg max-w-2xl mx-auto">
            Explore alguns dos locais históricos mais importantes de Recife
          </p>
        </div>
        
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {featuredLocations.map(location => (
            <LocationCard key={location.id} location={location} />
          ))}
        </div>
        
        <div className="text-center mt-10">
          <Link to="/locations">
            <Button variant="outline" className="border-recife-primary text-recife-primary hover:bg-recife-primary hover:text-white">
              Ver todos os locais
            </Button>
          </Link>
        </div>
      </div>
    </section>
  );
};

export default FeaturedLocations;
