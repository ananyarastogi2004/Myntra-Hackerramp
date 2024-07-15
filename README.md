# Myntra-Hackerramp
#Seasonal Colour Analysis
Inspired by the popular trend of seasonal color analysis among Gen Z, fueled by social media influencers we thought of creating a tool that performs a detailed colour analysis for free and then provide personalized recommendations to the users according to the analysis.Seasonal Color analysis is a method that’s used to determine which colors look best with a person's natural skin colour by categorizing them into one of four seasonal colour palettes.

Detailed Explanation of Color - Analysis Feature

1. The app scans the customer's face using an in-app camera, employing machine learning frameworks to detect and classify key facial regions. We utilize the Flutter image package and Google ML Face Detection to determine separate Hex Values for different regions like the forehead, jawline, and cheeks. These Hex values are then used to generate a detailed, in-depth seasonal color analysis customized for each customer.

2. This analysis includes identifying the best color shades according to the customer's seasonal palette, leveraging the OpenAI API. It covers a list of suitable colors, the customer’s unique color palette, and the suitability of neon and metallic colors.

3. We also provide a virtual color try-on feature, enabling users to try different colors on their faces. Users can save their preferred colors, enhancing our recommendation system.

4. Based on this comprehensive color analysis, we generate curated outfits for customers. Moving forward, we plan to enhance our recommendation system by integrating advanced machine learning algorithms such as content-based filtering, collaborative filtering, and decision trees.

# Outfit Completor
Our solution addresses the problem of unused outfits lying in people's wardrobes, which they want to upscale by getting the perfect match for them. To achieve this all the user has to do is to follow these basic steps. Suppose, a user uploads a picture of a white, ribbed crop top on Myntra. Using trendy pics from the FWD section, recent and relevant trends, data of what other users like to pair similar articles with, AI-powered style assistant APIs  and user’s personal profile(color palette and body type) the application will curate trendy matching recommendations for the user’s article. In this case best pairings for the top (apt denims, pants, cargos, skirts, accessories etc.). Later we intend to use ML based techniques to enhance these recommendations for a large user base(Future Prospect).

 Detailed Explanation of Outfit Completor
 
1. An in app camera will be used to scan the article owned by the user.
2. We’ll be using an Image Classification, CNN type Model to classify the type of clothing item in the image and categorize it (T-Shirts, shirts, skirt, cropped tee etc).
3. A labeled dataset of images (each image being tagged with the type of clothing it belongs to) will be used for training.
4. We can even  use the categorization available on Myntra (the FWD section)
5. For  feature extraction we intend to use  pre trained CNNs available in deep learning libraries like TensorFlow and PyTorch and extract key features of the product for instance it’s color, material of the article, it’s fit (skinny, baggy, regular etc) and map it to existing product categories on Myntra.
6. We’ll then use AI powered fashion and styling engine’s  APIs, OpenAI APIs, color theory based algorithms, data from fashion blogs, trending pieces from the FWD section of Myntra combined with the result of customer’s color analysis and body type to generate the perfect, trendy and personalized recommendations to pair with the uploaded article.
